{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.vasco.refresh;
in {
  options.vasco.refresh = {
    enable = lib.mkEnableOption "refresh";
    package = lib.mkOption {
      default = pkgs.vasco.initfs;
      example = pkgs.vasco.initfs;
      type = pkgs.lib.types.package;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.timers.refresh = {
      enable = true;
      description = "timer to start renew service";
      name = "refresh.timer";
      after = ["timers.target"];
      timerConfig = {
        OnCalendar = "20:00:00";
        Unit = "refresh.service";
      };
    };
    systemd.services.refresh = {
      description = "service to automatically refresh a tailscale auth token on disk";
      after = [
        "cryptsetup.target"
        "tpm2.target"
      ];

      serviceConfig = {
        Type = "oneshot";
        User = "refresh";
        Group = "refresh";
        WorkingDirectory = "/run/user/refresh";
        ExecStart = "${pkgs.vasco.initfs}/bin/initfs token renew -d /run/user/refresh -c /tmp/creds.json";
      };
    };

    systemd.tmpfiles.settings = {
      "00-refresh" = {
        "/run/user/refresh" = {
          d = {
            user = "refresh";
            group = "refresh";
            mode = "0700";
          };
        };
      };
    };

    users.users = {
      refresh = {
        description = "Refresh Service";
        home = "/run/user/refresh";
        group = "refresh";
        useDefaultShell = true;
        isSystemUser = true;
      };
    };

    users.groups = {
      refresh = {};
    };
  };
}
