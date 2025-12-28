{
  pkgs,
  inputs,
  ...
}: {
  nix = {
    package = pkgs.unstable.lixPackageSets.stable.lix;
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.unstable;
      home.flake = inputs.home;
    };
    nixPath = [
      "nixpkgs=/etc/channels/nixpkgs"
      "home-manager=/etc/channels/home-manager"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
    settings.experimental-features = ["nix-command" "flakes"];
  };

  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
  environment.etc."channels/home-manager".source = inputs.home.outPath;
}
