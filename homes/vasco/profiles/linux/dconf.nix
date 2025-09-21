# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    "apps/seahorse/listing" = {
      keyrings-selected = ["gnupg://"];
    };

    "org/gnome/Console" = {
      custom-font = "JetBrainsMonoNL Nerd Font Mono 10";
      font-scale = 1.8;
      last-window-maximised = false;
      last-window-size = mkTuple [1920 1168];
      theme = "night";
      use-system-font = false;
    };

    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [768 600];
    };

    "org/gnome/cheese" = {
      burst-delay = 1000;
      camera = "Integrated RGB Camera  Integrat";
      photo-x-resolution = 1920;
      photo-y-resolution = 1080;
      video-x-resolution = 1920;
      video-y-resolution = 1080;
    };

    "org/gnome/clocks/state/window" = {
      maximized = false;
      panel-id = "world";
      size = mkTuple [870 690];
    };

    "org/gnome/control-center" = {
      last-panel = "multitasking";
      window-state = mkTuple [1890 1162 false];
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = ["X-SuSE-YaST"];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/vasco/.config/nix/config/wallpapers/newyork.jpg";
      picture-uri-dark = "file:///home/vasco/.config/nix/config/wallpapers/newyork.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [(mkTuple ["xkb" "pt"]) (mkTuple ["xkb" "us"])];
      xkb-options = ["terminate:ctrl_alt_bksp"];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-size = 24;
      cursor-theme = "Adwaita";
      enable-animations = false;
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      application-children = ["org-gnome-settings" "firefox" "gnome-power-panel" "discord" "spotify" "thunderbird" "gnome-network-panel" "code" "slack" "org-gnome-screenshot" "zoom" "org-gnome-nautilus" "idea-ultimate" "code-url-handler" "org-gnome-evince" "chromium-browser" "transmission-gtk" "brave-browser" "org-gnome-console" "ca-desrt-dconf-editor" "pavucontrol" "obsidian" "webcord" "org-gnome-epiphany" "org-gnome-software" "org-gnome-extensions"];
      show-banners = true;
    };

    "org/gnome/desktop/notifications/application/brave-browser" = {
      application-id = "brave-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/ca-desrt-dconf-editor" = {
      application-id = "ca.desrt.dconf-editor.desktop";
    };

    "org/gnome/desktop/notifications/application/calibre-ebook-edit" = {
      application-id = "calibre-ebook-edit.desktop";
    };

    "org/gnome/desktop/notifications/application/chromium-browser" = {
      application-id = "chromium-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/code-url-handler" = {
      application-id = "code-url-handler.desktop";
    };

    "org/gnome/desktop/notifications/application/code" = {
      application-id = "code.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/idea-ultimate" = {
      application-id = "idea-ultimate.desktop";
    };

    "org/gnome/desktop/notifications/application/obsidian" = {
      application-id = "obsidian.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-epiphany" = {
      application-id = "org.gnome.Epiphany.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evince" = {
      application-id = "org.gnome.Evince.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-extensions" = {
      application-id = "org.gnome.Extensions.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-screenshot" = {
      application-id = "org.gnome.Screenshot.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-software" = {
      application-id = "org.gnome.Software.desktop";
    };

    "org/gnome/desktop/notifications/application/org-prismlauncher-prismlauncher" = {
      application-id = "org.prismlauncher.PrismLauncher.desktop";
    };

    "org/gnome/desktop/notifications/application/org-remmina-remmina" = {
      application-id = "org.remmina.Remmina.desktop";
    };

    "org/gnome/desktop/notifications/application/pavucontrol" = {
      application-id = "pavucontrol.desktop";
    };

    "org/gnome/desktop/notifications/application/slack" = {
      application-id = "slack.desktop";
    };

    "org/gnome/desktop/notifications/application/spotify" = {
      application-id = "spotify.desktop";
    };

    "org/gnome/desktop/notifications/application/thunderbird" = {
      application-id = "thunderbird.desktop";
    };

    "org/gnome/desktop/notifications/application/transmission-gtk" = {
      application-id = "transmission-gtk.desktop";
    };

    "org/gnome/desktop/notifications/application/webcord" = {
      application-id = "webcord.desktop";
    };

    "org/gnome/desktop/notifications/application/zoom" = {
      application-id = "Zoom.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
      speed = -0.242009;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.0;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/vasco/.local/share/backgrounds/2023-03-06-01-40-06-crosswalk.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = ["org.gnome.Settings.desktop" "org.gnome.Contacts.desktop" "org.gnome.Nautilus.desktop"];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
      event-sounds = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Shift><Super>q"];
      maximize = [];
      minimize = [];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-10 = ["<Super><Shift>0"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
      move-to-workspace-down = [];
      move-to-workspace-last = [];
      move-to-workspace-left = [];
      move-to-workspace-right = [];
      move-to-workspace-up = [];
      switch-applications = [];
      switch-applications-backward = [];
      switch-group = [];
      switch-group-backward = [];
      switch-panels = [];
      switch-panels-backward = [];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-10 = ["<Super>0"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-last = [];
      switch-to-workspace-left = [];
      switch-to-workspace-right = [];
      toggle-fullscreen = [];
      unmaximize = [];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
      workspace-names = [];
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/epiphany/state" = {
      is-maximized = false;
      window-size = mkTuple [1920 876];
    };

    "org/gnome/evince" = {
      document-directory = "file:///home/vasco/Documents/Programming/github.com/typst-resume-template";
      pictures-directory = "file:///home/vasco/Downloads";
    };

    "org/gnome/evince/default" = {
      continuous = false;
      dual-page = false;
      dual-page-odd-left = false;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = false;
      sidebar-page = "thumbnails";
      sidebar-size = 132;
      sizing-mode = "free";
      window-ratio = mkTuple [1.481481 1.387626];
      zoom = 0.852153;
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/file-roller/dialogs/extract" = {
      height = 800;
      recreate-folders = true;
      skip-newer = false;
      width = 1000;
    };

    "org/gnome/file-roller/file-selector" = {
      show-hidden = false;
      sidebar-size = 300;
      sort-method = "name";
      sort-type = "ascending";
      window-size = mkTuple [(-1) (-1)];
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 525;
      window-width = 948;
    };

    "org/gnome/gnome-screenshot" = {
      delay = 1;
      include-pointer = false;
      last-save-directory = "file:///home/vasco/Pictures";
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = false;
      dynamic-workspaces = true;
      edge-tiling = false;
      focus-change-on-pointer-rest = true;
      overlay-key = "";
      workspaces-only-on-primary = false;
    };

    "org/gnome/mutter/keybindings" = {
      cancel-input-capture = [];
      switch-monitor = [];
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "extra-large";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [1920 1168];
      initial-size-file-chooser = mkTuple [890 550];
      maximized = true;
    };

    "org/gnome/nm-applet/eap/01be2d6c-7778-4d9f-a621-9e4c54b3ac93" = {
      ignore-ca-cert = true;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/31c195b0-27f9-48fb-aefc-af798a52e162" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/64f55502-e848-43c3-82f8-78cc1a53e477" = {
      ignore-ca-cert = true;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/7003324d-b57c-4cda-a85b-9b393a96c629" = {
      ignore-ca-cert = true;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/b76f6823-e6e6-4946-9228-f5a743a0e5af" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/cb9f9246-632c-4a2f-b848-c1a464fc51e1" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/ff42e62b-b459-4e49-897d-5b3104bfaa28" = {
      ignore-ca-cert = true;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;
      night-light-schedule-automatic = false;
      night-light-schedule-to = 8.0;
      night-light-temperature = mkUint32 2255;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"];
      help = [];
      logout = ["<Shift><Super>e"];
      next = ["XF86HangupPhone"];
      next-static = ["XF86AudioNext" "<Ctrl>XF86AudioNext" "XF86HangupPhone"];
      play = ["XF86NotificationCenter"];
      previous = ["XF86PickupPhone"];
      previous-static = ["XF86AudioPrev" "<Ctrl>XF86AudioPrev" "XF86PickupPhone"];
      rotate-video-lock-static = [];
      screensaver = ["<Super>q"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "ghostty";
      name = "terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Shift><Super>s";
      command = "gnome-screenshot -i";
      name = "screenshot";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>d";
      command = "albert toggle";
      name = "albert";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };

    "org/gnome/shell" = {
      command-history = ["lg"];
      disable-user-extensions = false;
      disabled-extensions = ["windowsNavigator@gnome-shell-extensions.gcampax.github.com" "system-monitor@gnome-shell-extensions.gcampax.github.com" "pop-shell@system76.com" "blur-my-shell@aunetx" "trayIconsReloaded@selfmade.pl" "dash-to-dock@micxgx.gmail.com" "tiling-assistant@leleat-on-github"];
      enabled-extensions = ["launch-new-instance@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" "Vitals@CoreCoding.com" "paperwm@paperwm.github.com"];
      favorite-apps = [];
      last-selected-power-profile = "power-saver";
      looking-glass-history = ["exit" "quit()" "global.compositor.backend.get_monitor_manager().experimental_hdr = 'on'" "global.compositor.backend.get_monitor_manager().experimental_hdr = 'off'"];
      remember-mount-password = false;
      welcome-dialog-last-shown-version = "43.2";
    };

    "org/gnome/shell/extensions/appindicator" = {
      tray-pos = "right";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      background-opacity = 0.8;
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      height-fraction = 1.0;
      hot-keys = false;
      multi-monitor = true;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      show-favorites = false;
      show-running = false;
      show-show-apps-button = true;
      show-trash = false;
    };

    "org/gnome/shell/extensions/paperwm" = {
      gesture-horizontal-fingers = 4;
      gesture-workspace-fingers = 4;
      horizontal-margin = 3;
      last-used-display-server = "Wayland";
      open-window-position = 0;
      restore-attach-modal-dialogs = "true";
      restore-edge-tiling = "false";
      restore-keybinds = ''
        {"switch-monitor":{"bind":"[\\"<Super>p\\",\\"XF86Display\\"]","schema_id":"org.gnome.mutter.keybindings"},"focus-active-notification":{"bind":"[\\"<Super>n\\"]","schema_id":"org.gnome.shell.keybindings"}}
      '';
      restore-workspaces-only-on-primary = "true";
      selection-border-radius-top = 10;
      selection-border-size = 20;
      show-workspace-indicator = true;
      vertical-margin = 3;
      vertical-margin-bottom = 3;
      window-gap = 2;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [""];
      move-down = ["<Shift><Super>j"];
      move-down-workspace = ["<Shift><Super>n"];
      move-left = ["<Shift><Super>h"];
      move-right = ["<Shift><Super>l"];
      move-up = ["<Shift><Super>k"];
      move-up-workspace = ["<Shift><Super>p"];
      new-window = [""];
      switch-down = ["<Super>j"];
      switch-down-workspace = ["<Super>n"];
      switch-left = ["<Super>h"];
      switch-next = [""];
      switch-previous = [""];
      switch-right = ["<Super>l"];
      switch-up = ["<Super>k"];
      switch-up-workspace = ["<Super>p"];
    };

    "org/gnome/shell/extensions/paperwm/workspaces" = {
      list = ["2bb41f90-ba52-4d14-aed5-02cac907f359" "5b53e196-7e2a-41be-9848-daca39232946" "5da64119-6dc6-4fc5-b4ff-d80223b6c47d" "f855fc26-eda3-49c5-95cc-b617e5369756" "0248e38b-514e-443c-8947-47b1b07189ea" "41a925fd-1355-49a5-b750-bfab0fc10e7e" "ef05a4ed-6682-463c-891b-e0fa42735693" "3e280f39-1247-4060-b0d3-c4e5991d3655" "92ac8bac-7d0b-4d57-8014-a94bdcdf9d1f" "1b9bf06a-ea59-41af-bfc3-60ea87cf9de7"];
    };

    "org/gnome/shell/extensions/paperwm/workspaces/0248e38b-514e-443c-8947-47b1b07189ea" = {
      index = 3;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/1b9bf06a-ea59-41af-bfc3-60ea87cf9de7" = {
      index = 9;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/2bb41f90-ba52-4d14-aed5-02cac907f359" = {
      index = 0;
      show-position-bar = true;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/3e280f39-1247-4060-b0d3-c4e5991d3655" = {
      index = 7;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/41a925fd-1355-49a5-b750-bfab0fc10e7e" = {
      index = 4;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/5b53e196-7e2a-41be-9848-daca39232946" = {
      index = 1;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/5da64119-6dc6-4fc5-b4ff-d80223b6c47d" = {
      index = 2;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/92ac8bac-7d0b-4d57-8014-a94bdcdf9d1f" = {
      index = 8;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/ef05a4ed-6682-463c-891b-e0fa42735693" = {
      index = 6;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/f855fc26-eda3-49c5-95cc-b617e5369756" = {
      index = 5;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "";
    };

    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = ["_memory_usage_" "__network-rx_max__" "__temperature_max__"];
      position-in-panel = 2;
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      shift-overview-down = [];
      shift-overview-up = [];
      show-screenshot-ui = [];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
      toggle-message-tray = [];
    };

    "org/gnome/shell/overrides" = {
      edge-tiling = false;
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/software" = {
      check-timestamp = mkInt64 1758370565;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1758377018;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 159;
      sort-column = "modified";
      sort-directories-first = false;
      sort-order = "descending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [960 1048];
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [(mkTuple [0.564706 0.933333]) (mkTuple [0.0 0.0]) (mkTuple [1.0 0.270588])];
      selected-color = mkTuple [true 1.0];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      last-folder-uri = "file:///home/";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 167;
      sort-column = "modified";
      sort-directories-first = false;
      sort-order = "descending";
      type-format = "category";
      window-position = mkTuple [26 23];
      window-size = mkTuple [960 1001];
    };

    "system/proxy" = {
      mode = "none";
    };
  };
}
