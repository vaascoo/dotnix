{pkgs, ...}: let
  gnomeApps = with pkgs; [
    pkgs.unstable.albert
    dconf-editor
    gnome-screenshot
    gnome-system-monitor
    gnome-tweaks
    networkmanager-openvpn
    pinentry-gnome3
  ];

  extensions = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    tiling-assistant
    vitals
  ];
in {
  environment.systemPackages = gnomeApps ++ extensions;

  programs.dconf.enable = true;
  programs.xwayland.enable = true;

  services = {
    dbus.enable = true;
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    xserver.desktopManager.gnome.enable = true;
    xserver.displayManager.gdm = {
      enable = true;
      autoSuspend = false;
      wayland = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];
  };
}
