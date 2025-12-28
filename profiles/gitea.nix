{pkgs, ...}: {
  services.gitea = {
    enable = true;
    settings = {
      session.COOKIE_SECURE = true;
      server = {
        DOMAIN = "git.vaascoo.pt";
        PROTOCOL = "http";
        HTTP_ADDR = "0.0.0.0";
        HTTP_PORT = 3000;
        ROOT_URL = "https://git.vaascoo.pt";
      };
      packages.ENABLED = true;
      ui.THEMES = "auto,gitea,arc-green,github-auto,github,github-dark,catppuccin-mocha-blue";
    };
  };
}
