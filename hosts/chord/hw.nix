{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["usbhid" "nvme" "xhci_pci" "usb_storage" "sd_mod"];
  boot.kernelParams = ["quiet"];

  fileSystems."/" = {
    device = "zroot/enc/root";
    fsType = "zfs";
    options = ["zfsutil"];
    neededForBoot = true;
  };

  fileSystems."/home" = {
    device = "zroot/enc/home";
    fsType = "zfs";
    options = ["zfsutil"];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "zroot/enc/nix";
    fsType = "zfs";
    options = ["zfsutil"];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
