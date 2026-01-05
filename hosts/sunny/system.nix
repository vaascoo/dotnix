{profiles, ...}: {
  imports = with profiles; [
    base
    server
    zfs
  ];

  vasco.remoteUnlock = {
    enable = true;
    enableDebugInitrd = true;
    keybag = {
      name = "keybag";
      device = "/dev/disk/by-partlabel/disk-one-keybag";
    };

    additionalKernelModules = [
      "e1000e"
    ];
  };

  # missing bootloader
  networking.hostId = "ba519675";
  system.stateVersion = "25.11";
}
