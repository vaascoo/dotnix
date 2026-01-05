{
  inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    golink.url = "github:tailscale/golink";
    golink.inputs.nixpkgs.follows = "unstable";
    home.url = "github:nix-community/home-manager/release-25.11";
    home.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence/master";
    lanzaboote.url = "github:nix-community/lanzaboote?ref=v1.0.0";
    latest.url = "github:NixOS/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # todo: find a better way to do this
    nixos-anywhere.url = "github:nix-community/nixos-anywhere?ref=e86fad431cf9161ca39747972bd255897572dc3b";
    nixos-anywhere.inputs.nixpkgs.follows = "nixpkgs";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {self, ...}: let
    lib = inputs.nixpkgs.lib.extend (final: _: {
      unstable = inputs.unstable.lib;
      vasco = import ./lib {
        inherit inputs;
        lib = final;
      };
    });
  in {
    inherit lib;
    formatter = lib.vasco.exposeFormatter;
    packages = lib.vasco.exposePackages {};
    homeConfigurations = lib.vasco.map {
      directory = ./homes;
      fn = lib.vasco.mkHomeManager;
    };
    nixosConfigurations = lib.vasco.map {
      directory = ./hosts;
      fn = lib.vasco.mkLinux;
    };
    diskoConfigurations = lib.vasco.exposeDisks;
    devShells = lib.vasco.forEachSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = pkgs.lib.attrValues self.packages.${system};
      };
    });
  };
}
