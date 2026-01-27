{
  lib,
  pkgs,
  profiles,
  ...
}: let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  commonPackages = with pkgs; [
    diff-so-fancy
    dogdns
    firefox
    ungoogled-chromium
    gh
    git-ignore
    htop
    lazygit
    jujutsu
    spotify
  ];
  commonProfiles = with profiles; [
    direnv
    emacs
    fish
    fzf
    git
    gc
    ghostty
    neovim
    tmux
    zsh
  ];

  linuxPackages = (with pkgs; [
    calibre
    evince
    feh
    helvum
    libreoffice
    neofetch
    openssh
    pavucontrol
    qalculate-gtk
    thunderbird
    waypipe
    wl-clipboard
    vscode-fhs
  ]);
  linuxProfiles = (with profiles.linux; [
    dconf
    foot
    gtk
    lightdark
    proton
    vicinae
  ]);

  darwinPackages = lib.mkIf isDarwin [];
  darwinProfiles = lib.mkIf isDarwin [];

  homeDir = "/home/vasco";
    # if isDarwin
    # then "/Users/vasco"
    # else "/home/vasco";
in {
  imports = commonProfiles ++ linuxProfiles;# ++ darwinProfiles;

  home = {
    username = "vasco";
    homeDirectory = homeDir;
    packages = commonPackages ++ linuxPackages;# ++ darwinPackages;
    stateVersion = "22.05";
  };

  programs.home-manager.enable = true;
}
