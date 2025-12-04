{...}: {
  programs.git = {
    enable = true;
    settings = {
      color.ui = true;

      commit = {
        gpgsign = "true";
        sign = "true";
      };

      gpg.format = "ssh";
      init.defaultBranch = "main";
      pull.rebase = true;
      url."git@github.com".pushinsteadOf = "https://github.com";

      user = {
        email = "vcvasco1@gmail.com";
        name = "vaascoo";
        signingkey = "~/.ssh/id_ed25519_sign.pub";
      };
    };
  };
}
