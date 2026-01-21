{profiles, ...}: {
  imports = with profiles; [
    base
    server
    zfs
  ];

  vasco.remoteUnlock = {
    enable = true;
    keybag = {
      name = "keybag";
      device = "/dev/disk/by-partlabel/disk-one-keybag";
    };

    additionalKernelModules = [
      "r8152"
    ];
  };

  networking.hostId = "ba519675";
  system.stateVersion = "25.11";
}
