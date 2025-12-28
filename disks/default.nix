{...}: {
  sunnyDisk = import ./zfs.nix {
    diskId = "/dev/disk/by-id/TODO-REPLACE-ME";
  };
}
