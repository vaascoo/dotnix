{...}: {
  services.forgejo = {
    enable = true;
    settings = {
      session.COOKIE_SECURE = true;
      server = {
        DOMAIN = "git.vaascoo.pt";
        PROTOCOL = "http";
        HTTP_ADDR = "100.97.110.115";
        HTTP_PORT = 3000;
        ROOT_URL = "https://git.vaascoo.pt";
      };
    };
  };
}
