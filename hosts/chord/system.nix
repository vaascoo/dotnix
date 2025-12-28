{
  profiles,
  ...
}: {
  imports = with profiles; [
    base
    laptop
    golink
    zfs
  ];

  networking.hostId = "5e8c59c3";
  system.stateVersion = "22.05";
}
