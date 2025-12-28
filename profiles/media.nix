{...}: {
  #TODO this will be moved from here
  services.nginx = {
    enable = true;
    virtualHosts = {
      "git.vaascoo.pt" = {
        forceSSL = true;
        useACMEHost = "vaascoo.pt";
        locations."/".proxyPass = "http://127.0.0.1:3000";
        extraConfig = ''
          client_max_body_size 1024M;
        '';
      };
    };
  };
  users.groups.media = {};
  users.users.media = {
    isSystemUser = true;
    group = "media";
    extraGroups = ["media"];
  };
  users.users.nginx.extraGroups = ["acme"];
}
