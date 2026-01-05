{pkgs, ...}: {
  imports = [
    ./webhost.nix
  ];

  services.forgejo = {
    enable = true;
    settings = {
      session.COOKIE_SECURE = true;
      server = {
        DOMAIN = "git.vaascoo.pt";
        PROTOCOL = "http";
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3000;
        ROOT_URL = "https://git.vaascoo.pt";
        SSH_PORT = 2222;
      };
    };
  };

  services.openssh.listenAddresses = [
      {
        addr = "127.0.0.1";
        port = 2222;
      }
      {
        addr = "[::1]";
        port = 2222;
      }
  ];

  networking.firewall.allowedTCPPorts = [ 2222 ];

  users.users.forgejo.packages = [pkgs.git];

  services.nginx.virtualHosts."git.vaascoo.pt" = {
    forceSSL = true;
    useACMEHost = "vaascoo.pt";
    locations."/".proxyPass = "http://127.0.0.1:3000";
    extraConfig = ''
      client_max_body_size 1024M;
    '';
  };
}
