{
  configDir,
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    agenix
  ];
  age = {
    identityPaths = [
      "/home/vasco/.ssh/id_ed25519"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
    ];
    ageBin = "${pkgs.age}/bin/age";
    secrets = {
      ovhCreds = lib.mkIf (config.services.nginx.enable) {
        file = "${configDir}/secrets/ovh.age";
        mode = "0600";
      };
    };
  };
}
