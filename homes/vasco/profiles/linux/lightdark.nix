{pkgs, ...}: let
  #TODO(vasco): this is very hardcoded; Make it more flexible
  toLight = pkgs.writeShellScript "to-light" ''
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'

    rm -f ~/.config/vicinae
    ln -sf ~/.config/vicinae-light ~/.config/vicinae
    systemctl --user restart vicinae-server
  '';

  toDark = pkgs.writeShellScript "to-dark" ''
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

    rm -f ~/.config/vicinae
    ln -sf ~/.config/vicinae-dark ~/.config/vicinae
    systemctl --user restart vicinae-server
  '';
in {
  systemd.user.timers.toggle-light-mode = {
    Unit.Description = "Timer to switch to light mode";
    # DayOfWeek Year-Month-Day Hour:Minute:Second
    Timer.OnCalendar = "07:00:00";
    Timer.Persistent = true;
    Install.WantedBy = ["timers.target"];
  };

  systemd.user.timers.toggle-dark-mode = {
    Unit.Description = "Timer to switch to dark mode";
    Timer.OnCalendar = "18:30:00";
    Timer.Persistent = true;
    Install.WantedBy = ["timers.target"];
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
