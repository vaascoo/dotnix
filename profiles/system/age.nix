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
    identityPaths = ["/home/vasco/.ssh/id_ed25519"];
    ageBin = "${pkgs.age}/bin/age";
    secrets = {
      wireguard = lib.mkIf (builtins.hasAttr "wgrnl" config.networking.wg-quick.interfaces) {
        file = "${configDir}/secrets/wireguard.age";
        mode = "0600";
      };
      gitlabRunner = lib.mkIf (config.services.gitlab-runner.enable) {
        file = "${configDir}/secrets/runner.age";
        mode = "0600";
      };
      ovhCreds = lib.mkIf (config.services.nginx.enable) {
        file = "${configDir}/secrets/ovh.age";
        mode = "0600";
      };
    };
  };
}
