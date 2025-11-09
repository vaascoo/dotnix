{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package =
      (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages
      (epkgs: with epkgs; [vterm]);
  };

  home.packages = with pkgs; [
    git
    ripgrep
    coreutils
    fd
    clang
    cmake
    gnumake

    editorconfig-core-c
    sqlite
    pandoc
    graphviz
  ];
}
