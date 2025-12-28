{profiles, ...}: {
  imports = with profiles; [
    base
    zfs
  ];

  # missing bootloader
  networking.hostId = "ba519675";
  system.stateVersion = "25.11";
}
