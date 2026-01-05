#!/usr/bin/env -S nix shell nixpkgs#cryptsetup nixpkgs#uv --command uv run --script
#
# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///

import argparse
import glob
import os
import shlex
import shutil
import subprocess
import sys
import tempfile

from typing import Any, Callable, Optional

ARGS: Any = None
FS_PATH = "/boot/bootstrap.bin"
FS_SIZE = 100 * (1 << 20)  # 1MiB
MAPPED_VOLUME_NAME= "bootstrap"
DEV_PATH = "/dev/mapper/bootstrap"
TEMP_DIR = tempfile.mkdtemp()
TEMP_KEY_FILE = os.path.join(TEMP_DIR, "temp_key")


class Color:
    Reset = "\033[0m"
    Red = "\033[31m"
    Green = "\033[32m"


def eprint(*values, **kargs):
    print(*values, file=sys.stderr, **kargs)


def success(*values):
    eprint(Color.Green, end="")
    eprint(*values)
    eprint(Color.Reset, end="")


def panic(*values):
    eprint(Color.Red, end="")
    eprint(*values)
    eprint(Color.Reset, end="")
    sys.exit(1)


def check_root():
    uid = os.geteuid()
    if uid != 0:
        panic("script must be run as root")

    success(f"running as root (uid={uid})")


def check_tpm():
    matches = glob.glob("/dev/tpmrm*")
    for match in matches:
        try:
            os.stat(match)
            success(f"found tpm2 device @ {match}")
            return match
        except Exception as ex:
            eprint(ex)
            break

    panic("no suitable TPM devices found")


def check_existing():
    if ARGS.force:
        return
    try:
        os.stat(FS_PATH)
    except FileNotFoundError:
        # does not exist - the good case
        success(f"{FS_PATH} does not exist")
        return
    except Exception as ex:
        eprint(ex)
    panic(f"'{FS_PATH}' exists or is not a regular file")


def create_placeholder():
    bail = lambda: panic(f"'{FS_PATH}': error creating file")

    with open(FS_PATH, "wb+") as f:
        if f.seek(FS_SIZE, os.SEEK_SET) < FS_SIZE:
            bail()

        if f.write(int(0).to_bytes()) < 0:
            bail()

    success(f"{FS_PATH} created with size {FS_SIZE}")

def cmd(command: str) -> Callable[[],None]:
    def inner():
        process_handle = subprocess.run(
            shlex.split(command),
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        try:
            process_handle.check_returncode()
            success(f"ran {command}")
        except Exception as ex:
            eprint(ex)
            panic(f"error running {command}")
    return inner

def create_temp_key():
    key: Optional[bytes] = None

    with open("/dev/urandom", "rb") as f:
        key = f.read(32)

    with open(TEMP_KEY_FILE, "wb+") as f:
        written = f.write(key)
        if written != 32:
            panic(f"error writing to temporary key file {TEMP_KEY_FILE}")
    success(f"generated temporary key under {TEMP_KEY_FILE}")

def mkfs_ext4():
    if ARGS.force:
        cmd(f"mkfs.ext4 {DEV_PATH} -F")()
    else:
        cmd(f"mkfs.ext4 {DEV_PATH}")()

def remove_temp_dir():
    shutil.rmtree(TEMP_DIR)
    success(f"{TEMP_DIR} pivot removed")

# cryptsetup luksFormat test --init-only --key-file temp_key --batch-mode
# systemd-cryptenroll --tpm2-device=auto --unlock-key-file=temp_key test
# systemd-cryptenroll --wipe-slot 0 test

# then open
# make an ext4 or vfat32 fs
# generate the ssh keys

# tailscale api generate key?

STAGES = [
    check_root,
    check_tpm,
    check_existing,
    create_placeholder,
    cmd(f"mount -t tmpfs -o mode=0755 -o size=1G none {TEMP_DIR}"),
    create_temp_key,
    cmd(f"cryptsetup luksFormat {FS_PATH} "
        f"--init-only --key-file {TEMP_KEY_FILE} --batch-mode"),
    cmd(f"systemd-cryptenroll --tpm2-device=auto --unlock-key-file={TEMP_KEY_FILE} {FS_PATH}"),
    cmd(f"systemd-cryptenroll --wipe-slot 0 {FS_PATH}"),
    # we have wiped the keyslot; we can unmount the dir
    cmd(f"umount {TEMP_DIR}"),
    cmd(f"systemd-cryptsetup attach {MAPPED_VOLUME_NAME} {FS_PATH} none tpm2-device=auto"),
    mkfs_ext4,
    cmd(f"mount {DEV_PATH} {TEMP_DIR}"),
    cmd(f"initfs token new -d {TEMP_DIR}"),
    lambda: input(),
    cmd(f"umount {TEMP_DIR}"),
    cmd(f"systemd-cryptsetup detach {MAPPED_VOLUME_NAME}"),
    remove_temp_dir,
]


def main():
    for stage in STAGES:
        stage()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--force", "-f", action="store_true", help="force the creation of bootstrap.bin"
    )
    ARGS = parser.parse_args()

    main()
