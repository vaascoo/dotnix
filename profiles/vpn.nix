{pkgs, ...}: {
  environment.systemPackages = [pkgs.mullvad-vpn];
  services.mullvad-vpn.enable = true;
}
