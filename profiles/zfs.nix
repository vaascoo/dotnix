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
  then let
    zfsPackage = config.boot.zfs.package;
  in {
    systemd.shutdownRamfs = {
      contents."/etc/systemd/system-shutdown/zpool".source = pkgs.lib.mkForce (pkgs.writeShellScript "zpool" ''
        ${zfsPackage}/bin/zfs rollback -r zroot/root@blank
        exec ${zfsPackage}/bin/zpool sync
      '');
      storePaths = [
        "${zfsPackage}/bin/zfs"
      ];
    };

    environment.persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/etc/secureboot"
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/var/lib"
        "/var/log"
      ];
      files = ["/etc/machine-id"];
    };
  }
  else {}
)
