{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "sr_mod"
    "virtio_blk"
  ];

  vasco.remoteUnlock = {
    enable = true;
    enableDebugInitrd = false;
    keybag = {
      name = "keybag";
      device = "/dev/disk/by-partlabel/disk-one-keybag";
    };
    additionalKernelModules = [
      "virtio"
      "virtio_net"
      "virtio_pci"
      "virtio_mmio"
    ];
  };

  boot.kernelModules = ["kvm-amd"];
  boot.zfs.devNodes = "/dev/disk/by-uuid";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
