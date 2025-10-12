{pkgs, ...}: let
  commandNotFound = pkgs.writeScript "" ''
    #!/usr/bin/env bash
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

    command_not_found_handler $@
  '';
in {
  home.sessionVariables.MANPAGER = "nvim +Man!";

  programs.fzf = {
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zellij = {
    enable = true;
  };

  programs.bat.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      hostname = {
        ssh_only = false;
        format = "[@](yellow)[$hostname](bold blue) ";
      };
      username = {
        show_always = true;
        format = "[$user](red)";
      };
    };
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellInit = ''
      set -U fish_greeting
    '';
    shellAliases = {
      l = "ls -algh";
      less = "bat --style=plain";
      ignore = "${pkgs.git-ignore}/bin/git-ignore $(${pkgs.git-ignore}/bin/git-ignore -l 2> /dev/null | ${pkgs.fzf}/bin/fzf -m)";
    };
    shellAbbrs = {
      S = "exec $SHELL";
      tf = "terraform";
      k = "kubectl";
      open = "xdg-open";
    };
    functions = {
      "fish_command_not_found".body = "${commandNotFound} $argv";
    };
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };
}
