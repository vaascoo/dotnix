{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.tailscale;
in {
  boot.initrd = {
    systemd.enable = true;
    kernelModules = ["tpm_crb"];
    systemd.emergencyAccess = config.users.users.root.hashedPassword;
    # systemd.network = config.systemd.network;
    systemd.network.networks."50-tailscale" = {
      matchConfig = {
        Name = cfg.interfaceName;
      };
      linkConfig = {
        Unmanaged = true;
        ActivationPolicy = "manual";
      };
    };

    network.ssh = {
      enable = true;
      ignoreEmptyHostKeys = true;
    };
    systemd.contents = {
      "/etc/fstab".text = ''
        /dev/mapper/tpm2bag /tpm2bag ext4 defaults 0 2
        /tpm2bag/var/lib/tailscale /var/lib/tailscale none bind,x-systemd.requires-mounts-for=/tpm2bag/var/lib/tailscale
        # nofail so it doesn't order before local-fs.target and therefore systemd-tmpfiles-setup
        /dev/mapper/keybag /keybag ext4 defaults,nofail,x-systemd.device-timeout=0,ro 0 2
      '';
      "/etc/tmpfiles.d/50-ssh-host-keys.conf".text = ''
        C /etc/ssh/ssh_host_ed25519_key 0600 - - - /tpm2bag/etc/ssh/ssh_host_ed25519_key
        C /etc/ssh/ssh_host_rsa_key 0600 - - - /tpm2bag/etc/ssh/ssh_host_rsa_key
      '';
    };
    systemd.services.systemd-tmpfiles-setup.before = ["sshd.service"];
    luks.devices.keybag = {
      device = "/dev/disk/by-uuid/4d518c17-da13-49a0-a003-ec183f36b03c";
      crypttabExtraOpts = ["tpm2-device=auto" "nofail"];
    };
    luks.devices.tpm2bag = {
      device = "/dev/disk/by-uuid/71667743-d8fe-49ad-ad86-3809351607f0";
      crypttabExtraOpts = ["tpm2-device=auto"];
    };
    systemd.packages = [cfg.package];
    systemd.initrdBin = [pkgs.iptables pkgs.iproute2 cfg.package];
    availableKernelModules = ["tun" "nft_chain_nat" "ext4" "igb"];

    systemd.services.tailscaled = {
      wantedBy = ["initrd.target"];
      serviceConfig.Environment = [
        "PORT=${toString cfg.port}"
        ''"FLAGS=--tun ${lib.escapeShellArg cfg.interfaceName}"''
      ];
    };

    systemd.contents."/etc/tmpfiles.d/50-tailscale.conf".text = ''
      L /var/run - - - - /run
    '';
    systemd.contents."/etc/hostname".source = config.environment.etc.hostname.source;

    systemd.extraBin.ping = "${pkgs.iputils}/bin/ping";

    systemd.additionalUpstreamUnits = ["systemd-resolved.service"];
    systemd.users.systemd-resolve = {};
    systemd.groups.systemd-resolve = {};
    systemd.contents."/etc/systemd/resolved.conf".source = config.environment.etc."systemd/resolved.conf".source;
    systemd.storePaths = ["${config.boot.initrd.systemd.package}/lib/systemd/systemd-resolved"];
    systemd.services.systemd-resolved = {
      wantedBy = ["initrd.target"];
      serviceConfig.ExecStartPre = "-+/bin/ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf";
    };
  };
}
