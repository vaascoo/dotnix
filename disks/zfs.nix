{
  diskId,
  espSize ? "1G",
  ...
}: let
  ESP = {
    type = "EF00";
    size = espSize;
    content = {
      type = "filesystem";
      format = "vfat";
      mountpoint = "/boot";
      mountOptions = ["nofail"];
    };
  };

  keybag = {
    size = espSize;
    content = {
      type = "luks";
      name = "keybag";
      initrdUnlock = false;
      # STATE (after secure boot is enabled):
      # systemd-cryptenroll --tpm2-device=auto --unlock-key-file=/tmp/keybag.key /dev/disk/by-partlabel/disk-one-keybag
      # systemd-cryptenroll --wipe-slot 0 /dev/disk/by-partlabel/disk-one-keybag
      content = {
        type = "filesystem";
        format = "ext4";
        mountpoint = null;
      };
    };
  };

  zfs = {
    size = "100%";
    content = {
      type = "zfs";
      pool = "zroot";
    };
  };

  zroot = {
    type = "zpool";
    rootFsOptions = {
      acltype = "posix";
      xattr = "sa";
      atime = "off";
      compression = "zstd";
      mountpoint = "none";
      normalization = "formD";
    };
    options.ashift = "12";
    postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";

    datasets = {
      "reserved" = {
        type = "zfs_fs";
        options.reservation = "20G";
      };
      "enc" = {
        type = "zfs_fs";
        options = {
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
        };
      };

      "enc/root" = {
        type = "zfs_fs";
        mountpoint = "/";
      };

      "enc/nix" = {
        type = "zfs_fs";
        mountpoint = "/nix";
      };

      "enc/home" = {
        type = "zfs_fs";
        mountpoint = "/home";
      };
    };
  };
in {
  disko.devices = {
    disk = {
      one = {
        device = diskId;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            inherit
              ESP
              keybag
              zfs
              ;
          };
        };
      };
    };

    zpool = {
      inherit zroot;
    };
  };
}
