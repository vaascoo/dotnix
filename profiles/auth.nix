{ ... }: {
  services.authelia = {
    enable = true;
    settings.server.address = "tcp://:31337";
    settings.theme = "auto";
  };


  services.nginx.virtualHosts."auth.vaascoo.pt" = {
    forceSSL = true;
    useACMEHost = "vaascoo.pt";
    locations."/".proxyPass = "http://127.0.0.1:31337";
  };
}
