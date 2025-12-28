{pkgs, ...}: let
  vicinaeConfig = {
    closeOnFocusLoss = false;
    considerPreedit = false;
    faviconService = "google";
    font = {
      size = 12.5;
    };
    keybinding = "default";
    keybinds = {};
    popToRootOnClose = true;
    rootSearch = {
      searchFiles = true;
    };
    window = {
      csd = true;
      opacity = 0.98;
      rounding = 10;
    };
  };
  darkTheme = {
    theme.name = "rose-pine";
  };
  lightTheme = {
    theme.name = "rose-pine-dawn";
  };
in {
  home.file.".config/vicinae-dark/vicinae.json" = {
    enable = true;
    text = builtins.toJSON (vicinaeConfig // darkTheme);
  };
  home.file.".config/vicinae-light/vicinae.json" = {
    enable = true;
    text = builtins.toJSON (vicinaeConfig // lightTheme);
  };

  home.packages = with pkgs; [
    vicinae
  ];

  systemd.user.services.vicinae-server = {
    Install.WantedBy = ["graphical-session.target"];
    Unit.Description = "vicinae server";
    Unit.After = ["graphical-session.target"];
    Service.Type = "simple";
    Service.ExecStart = "${pkgs.vicinae}/bin/vicinae server";
  };
}
