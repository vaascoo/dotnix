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
    gh
    git-ignore
    htop
    lazygit
    spotify
  ];
  commonProfiles = with profiles; [
    direnv
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
    brave
    calibre
    evince
    feh
    helvum
    neofetch
    pavucontrol
    qalculate-gtk
    thunderbird
    waypipe
    wl-clipboard
  ]);
  linuxProfiles = lib.optional isLinux (with profiles.linux; [
    dconf
    foot
    gtk
    lightdark
    proton
    ssh
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
