{...}: {
  sunnyDisk = import ./zfs.nix {
    diskId = "/dev/sda";
  };

  cloudyDisk = import ./zfs.nix {
    diskId = "/dev/nvme0n1";
  };

  vmDisk = import ./zfs.nix {
    diskId = "/dev/vda";
  };
}
