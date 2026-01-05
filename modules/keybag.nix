# heavily inspired by https://github.com/ElvishJerricco/stage1-tpm-tailscale
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.vasco.remoteUnlock;
in {
  options.vasco.remoteUnlock = {
    enable = lib.mkEnableOption "remote-unlock";
    keybag.name = lib.mkOption {
      type = lib.types.str;
    };
    keybag.device = lib.mkOption {
      type = lib.types.str;
    };
    enableDebugInitrd = lib.mkEnableOption "enable a debug shell";
    additionalKernelModules = lib.mkOption {
      type = with lib.types; (listOf str);
      default = [];
    };
  };
  #STATE: first login needs to be done manually
  config = lib.mkIf cfg.enable {
    boot.kernelParams = lib.flatten ((lib.optional cfg.enableDebugInitrd [
        "rd.systemd.debug_shell"
        "rd.systemd.unit=rescue.target"
      ])
      ++ ["ip=dhcp"]);

    boot.initrd.availableKernelModules =
      [
        "ext4"

        "tun"
        "nft_chain_nat"
      ]
      ++ cfg.additionalKernelModules;

    boot.initrd.systemd = {
      enable = true;
      dbus.enable = true;
      packages = [pkgs.tailscale];
      initrdBin = with pkgs; [iptables iproute2 tailscale killall];
      emergencyAccess = cfg.enableDebugInitrd;
      services.tailscaled = {
        wantedBy = ["initrd.target"];
        serviceConfig.Environment = [
          "PORT=${toString config.services.tailscale.port}"
          ''"FLAGS=--tun tailscale0"''
        ];
      };
      contents = {
        "/etc/fstab".text = ''
          /dev/mapper/${cfg.keybag.name} /${cfg.keybag.name} ext4 defaults,nofail,x-systemd.device-timeout=0 0 2
          /${cfg.keybag.name}/var/lib/tailscale /var/lib/tailscale none bind x-systemd.requires-mounts-for=/${cfg.keybag.name}
        '';
      };
      tmpfiles.settings = {
        "10-keybag" = {
          ${cfg.keybag.name} = {
            d = {
              user = "root";
              group = "root";
              mode = "0755";
            };
          };
          "/var/lib/tailscale" = {
            d = {
              user = "root";
              group = "root";
              mode = "0755";
            };
          };
          "/var/run" = {
            L = {
              argument = "/run";
            };
          };
        };
      };
      services.systemd-tmpfiles.before = ["systemd-cryptsetup@${cfg.keybag.name}.service"];
      network.enable = true;
      network.networks."10-lan" = {
        matchConfig.Name = "enp*";
        DHCP = "yes";
      };
      network.networks."50-tailscale" = {
        matchConfig = {
          Name = "tailscale0";
        };
        linkConfig = {
          Unmanaged = true;
          ActivationPolicy = "manual";
        };
      };

      extraBin.ping = "${pkgs.iputils}/bin/ping";
    };

    boot.initrd.services.resolved.enable = true;
    networking.useDHCP = true;

    boot.initrd.luks.devices.${cfg.keybag.name} = {
      inherit (cfg.keybag) device;
      crypttabExtraOpts = ["tpm2-device=auto" "noauto" "nofail"];
    };
  };
}
