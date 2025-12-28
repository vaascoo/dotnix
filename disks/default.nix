{...}: {
  sunnyDisk = import ./zfs.nix {
    diskId = "/dev/sda";
  };
}
