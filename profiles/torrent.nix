{
  config,
  lib,
  ...
}: {
  services.transmission = {
    enable = true;
    openFirewall = true;
  };

  services.nginx.virtualHosts."torrent.vaascoo.pt" = lib.mkIf config.services.nginx.enable {
    forceSSL = true;
    useACMEHost = "vaascoo.pt";
    locations."/".proxyPass = "http://127.0.0.1:9091";
  };
}
