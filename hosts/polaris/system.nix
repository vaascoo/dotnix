{
  config,
  lib,
  modulesPath,
  profiles,
  pkgs,
  ...
}: {
  imports = with profiles.system; [
    (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    zfs
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOhkfgFv8yH7Td4QMadLFDCgMrXpI7QQaMNBM2YeN/+k"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMqYSdBgEOBpoB0eioYuCBiSN/OVlK4xX7dmJ6P9an9F"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMw/MbYbMQUeNcdXAqBZ18IsmU8+rJGpjTP0NL3OprD"
    ];
    initialHashedPassword = "$6$yMG9ttPdqMEGD1Ge$erC5p3MYZL/AiCpdAnNaln/XPvcw3qMqlR.ZjCAe3If53K5ADb9FFMM3zSR1xURoLJ/Vv5NDafTbeNC1k89M20";
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22];
  };

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod"];
  boot.initrd.kernelModules = ["virtio_pci"];
  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      port = 2222;
      authorizedKeys = config.users.users.root.openssh.authorizedKeys.keys;
      hostKeys = [
        "/boot/ssh_host_rsa_key"
        "/boot/ssh_host_ed25519_key"
      ];
    };
  };

  networking.useDHCP = lib.mkDefault true;

  disko.devices.disk.sda = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          name = "boot";
          size = "1M";
          type = "EF02";
        };
        esp = {
          name = "ESP";
          size = "500M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        zfs = {
          size = "100%";
          content = {
            type = "zfs";
            pool = "zroot";
          };
        };
      };
    };
  };

  disko.devices.zpool.zroot = {
    type = "zpool";
    rootFsOptions = {
      mountpoint = "none";
      compression = "zstd";
      acltype = "posixacl";
      xattr = "sa";
      "com.sun:auto-snapshot" = "true";
    };

    postCreateHook = "zfs snapshot zroot/root@blank";
    options.ashift = "12";
    datasets = {
      "root" = {
        type = "zfs_fs";
        options = {
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
        };
        mountpoint = "/";
      };
      "root/nix" = {
        type = "zfs_fs";
        options.mountpoint = "/nix";
        mountpoint = "/nix";
      };
      "root/home" = {
        type = "zfs_fs";
        options.mountpoint = "/home";
        mountpoint = "/home";
      };
    };
  };

  zramSwap.enable = true;

  networking.hostId = "2b4e929b";

  system.stateVersion = "25.05";
}
