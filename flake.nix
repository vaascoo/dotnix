{
  inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home.url = "github:nix-community/home-manager/release-25.05";
    home.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence/master";
    lanzaboote.url = "github:nix-community/lanzaboote?ref=v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    latest.url = "github:NixOS/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {...}: let
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
  };
}
