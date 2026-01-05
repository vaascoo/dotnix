{profiles, ...}: {
  imports = with profiles; [
    base
    server
    zfs
  ];

  # missing bootloader
  networking.hostId = "ba519675";
  system.stateVersion = "25.11";
}
