{...}: {
  programs.vicinae = {
    enable = true;

    systemd = {
      enable = true;
      autoStart = true;
    };

    settings = {
      consider_preedit = false;
      favicon_service = "google";
      font = {
        size = 12.5;
      };
      keybinding = "default";
      keybinds = {};
      pop_to_root_on_close = true;
      root_search = {
        search_files = true;
      };
      window = {
        csd = true;
        opacity = 0.98;
        rounding = 10;
      };
    };
  };
}
