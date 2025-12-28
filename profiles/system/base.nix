{
  pkgs,
  ...
}: {
  imports = [
    ./age.nix
    ./bootloader.nix
    ./doh.nix
    ./gc.nix
    ./keymap.nix
    ./tailscale.nix
    ./users.nix
    ./virt.nix
  ];

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    alejandra
    dnsutils
    file
    inetutils
    inotify-tools
    iproute2
    iw
    killall
    lsof
    nmap
    pciutils
    ripgrep
    sysstat
    tmux
    unstable.python3
    unzip
    usbutils
    wget
    wireguard-tools
    zip
  ];

  zramSwap.enable = true;
  time.timeZone = "Europe/Lisbon";
  environment.sessionVariables = {
    EDITOR = "nvim";
  };
}
