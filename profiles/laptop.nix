{
  lib,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./fonts.nix
    ./gnome.nix
    ./pipewire.nix
    ./wayland.nix
  ];

  services.avahi.enable = true;
  services.flatpak.enable = true;
  services.pcscd.enable = true;

  networking.firewall.enable = false;
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
