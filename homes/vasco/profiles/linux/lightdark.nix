{pkgs, ...}: let
  #TODO(vasco): this is very hardcoded; Make it more flexible
  toLight = pkgs.writeShellScript "to-light" ''
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
  '';

  toDark = pkgs.writeShellScript "to-dark" ''
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
  '';
in {
  systemd.user.timers.toggle-light-mode = {
    Unit.Description = "Timer to switch to light mode";
    # DayOfWeek Year-Month-Day Hour:Minute:Second
    Timer.OnCalendar = "08:00:00";
    Timer.Persistent = true;
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.timers.toggle-dark-mode = {
    Unit.Description = "Timer to switch to dark mode";
    Timer.OnCalendar = "20:00:00";
    Timer.Persistent = true;
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.services.toggle-light-mode = {
    Unit.Description = "Service to switch to light mode";
    Service.Type = "oneshot";
    Service.ExecStart = "${toLight}";
  };

  systemd.user.services.toggle-dark-mode = {
    Unit.Description = "Service to switch to dark mode";
    Service.Type = "oneshot";
    Service.ExecStart = "${toDark}";
  };
}
