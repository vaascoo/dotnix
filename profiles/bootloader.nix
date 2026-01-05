{
  config,
  hostConfig,
  pkgs,
  lib,
  ...
}:
{
  boot.loader.efi.canTouchEfiVariables = true;
}
// (
  if hostConfig.secureboot.enable
  then {
    boot.bootspec.enable = true;
    environment.systemPackages = with pkgs; [sbctl];

    boot.lanzaboote = {
      enable = true;
      autoGenerateKeys.enable = hostConfig.secureboot.generateKeys;
      autoEnrollKeys.enable = true;
      settings.editor = null;
      pkiBundle = "/var/lib/sbctl/";
    };
  }
  else {
    boot.loader.systemd-boot = {
      enable = true;
      editor = false;
    };
  }
)
