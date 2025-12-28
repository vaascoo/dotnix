{
  config,
  hostConfig,
  pkgs,
  ...
}:
{
  boot.zfs.allowHibernation = true;
  boot.zfs.forceImportRoot = false;
  boot.initrd.availableKernelModules = ["zfs"];
  boot.kernelModules = ["zfs"];
  boot.supportedFilesystems = ["zfs"];
  services.zfs.autoScrub.enable = true;
}
// (
  if hostConfig.impermanence.enable
  then {
    systemd.shutdownRamfs.contents."/etc/systemd/system-shutdown/zpool".source = let
      zfsPackage = config.boot.zfs.package;
    in
      pkgs.lib.mkForce (pkgs.writeShellScript "zpool" ''
        ${zfsPackage}/bin/zfs rollback -r zroot/root@blank
        exec ${zfsPackage}/bin/zpool sync
      '');
    environment.persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/etc/secureboot"
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/var/lib"
        "/var/log"
      ];
    };
    environment.etc."machine-id".source = "/nix/persist/etc/machine-id";
  }
  else {}
)
