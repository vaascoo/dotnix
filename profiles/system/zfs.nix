{pkgs, config, ...}: let
  zfsPackage = config.boot.zfs.package;
in {
  boot.zfs.allowHibernation = true;
  boot.zfs.forceImportRoot = false;
  boot.initrd.availableKernelModules = ["zfs"];
  boot.kernelModules = [ "zfs" ];
  boot.supportedFilesystems = ["zfs"];
  services.zfs.autoScrub.enable = true;

  systemd.shutdownRamfs.contents."/etc/systemd/system-shutdown/zpool".source = pkgs.lib.mkForce (pkgs.writeShellScript "zpool" ''
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
      "/etc/secrets"
      "/etc/gitlab-runner"
      "/etc/rancher/k3s"
    ];
  };
  environment.etc."machine-id".source = "/nix/persist/etc/machine-id";
}
