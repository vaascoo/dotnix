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
    dash-to-dock
    paperwm
    tiling-assistant
    tiling-shell
    tray-icons-reloaded
    vitals
  ];
in {
  environment.systemPackages = gnomeApps ++ extensions;

  programs.dconf.enable = true;

  services = {
    dbus.enable = true;
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    xserver.enable = true;
    xserver.desktopManager.gnome.enable = true;
    xserver.displayManager.gdm = {
      enable = true;
      autoSuspend = false;
      wayland = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];
  };
}
