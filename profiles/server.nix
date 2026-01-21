{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./forgejo.nix
    ./shiori.nix
    ./torrent.nix
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings.PasswordAuthentication = false;
  };

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  systemd.services.sshd.after = lib.mkIf config.services.tailscale.enable ["tailscaled.service"];

  services.logind.settings.Login = {
    IdleAction = "ignore";
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  users.users.vasco.shell = lib.mkForce pkgs.bash;
}
