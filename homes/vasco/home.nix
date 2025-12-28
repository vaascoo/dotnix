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

  linuxPackages = lib.optional isLinux (with pkgs; [
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
  linuxProfiles = lib.optional isLinux (with profiles.linux; [
    dconf
    foot
    gtk
    lightdark
    proton
    vicinae
  ]);

  darwinPackages = lib.optional isDarwin [];
  darwinProfiles = lib.optional isDarwin [];

  homeDir =
    if isDarwin
    then "/Users/vasco"
    else "/home/vasco";
in {
  imports = lib.flatten (commonProfiles ++ linuxProfiles ++ darwinProfiles);

  home = {
    username = "vasco";
    homeDirectory = homeDir;
    packages = lib.flatten (commonPackages ++ linuxPackages ++ darwinPackages);
    stateVersion = "22.05";
  };

  programs.home-manager.enable = true;
}
