{profiles, ...}: {
  imports = with profiles; [
    base
    server
    zfs
  ];

  services.openssh.listenAddresses = [
    {
      addr = "0.0.0.0";
      port = 22;
    }
  ];

  # missing bootloader
  networking.hostId = "ba519675";
  system.stateVersion = "25.11";
}
