{config, ...}: {
  services.authelia.instances.main = {
    enable = true;
    settings = {
      theme = "auto";
      access_control = {
        default_policy = "one_factor";
        rules = [];
      };
      server.address = "tcp://127.0.0.1:31337";

      session = {
        name = "authelia_session";
        expiration = 3600;
        inactivity = 300;
        cookies = [
          {
            domain = "vaascoo.pt";
            authelia_url = "https://auth.vaascoo.pt";
            default_redirection_url = "https://git.vaascoo.pt";
          }
        ];
      };

      # STATE: This file is not managed by nix at the moment
      authentication_backend.file = {
        path = "/var/lib/authelia-main/users.yml";
        watch = true;
        password = {
          algorithm = "argon2";
          argon2.variant = "argon2id";
        };
      };

      storage.local.path = "/var/lib/authelia-main/db.sqlite3";

      notifier.filesystem.filename = "/var/lib/authelia-main/notification.txt";

      identity_providers.oidc.clients = [
        {
        }
      ];
    };

    secrets = {
      jwtSecretFile = config.age.secrets.authJwt.path;
      storageEncryptionKeyFile = config.age.secrets.authKey.path;
    };
  };

  services.nginx.virtualHosts."auth.vaascoo.pt" = {
    forceSSL = true;
    useACMEHost = "vaascoo.pt";
    locations."/" = {
      proxyPass = "http://127.0.0.1:31337";
      extraConfig = ''
        proxy_set_header Host $host;
      '';
    };
  };
}
