{config, ...}: {
  services.authelia.instances.main = {
    enable = true;
    settings.server.address = "tcp://:31337";
    settings.theme = "auto";
    secrets.jwtSecretFile = config.age.secrets.authJwt.path;
    secrets.storageEncryptionKeyFile = config.age.secrets.authKey.path;
  };

  services.nginx.virtualHosts."auth.vaascoo.pt" = {
    forceSSL = true;
    useACMEHost = "vaascoo.pt";
    locations."/".proxyPass = "http://127.0.0.1:31337";
  };
}
