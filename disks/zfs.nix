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
            inherit ESP zfs;
          };
        };
      };
    };

    zpool = {
      inherit zroot;
    };
  };
}
