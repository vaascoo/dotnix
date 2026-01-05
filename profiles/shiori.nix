{pkgs, ...}: {
  imports = [
    ./webhost.nix
  ];

  services.shiori = {
    enable = true;
    address = "127.0.0.1";
    port = 4000;
  };

  services.nginx.virtualHosts."shiori.vaascoo.pt" = {
    forceSSL = true;
    useACMEHost = "vaascoo.pt";
    locations."/".proxyPass = "http://127.0.0.1:4000";
  };
}
