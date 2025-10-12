{
  inputs,
  configDir ? ../config,
  profilesDir ? ../profiles,
  modulesDir ? ../modules,
  homesDir ? ../homes,
  lib,
  ...
}: let
  inherit (inputs.agenix.nixosModules) age;
  inherit (inputs.disko.nixosModules) disko;
  inherit (inputs.home.lib) homeManagerConfiguration;
  inherit (inputs.home.nixosModules) home-manager;
  inherit (inputs.impermanence.nixosModules) impermanence;
  inherit (inputs.lanzaboote.nixosModules) lanzaboote;

  forEachSystem = fn: let
    systems = ["aarch64-darwin" "x86_64-linux"];
  in
    builtins.listToAttrs (builtins.map (system: {
        name = system;
        value = fn system;
      })
      systems);

  exposePackages = {directory ? ../packages}:
    forEachSystem (
      system:
        lib.filesystem.packagesFromDirectoryRecursive {
          inherit (inputs.nixpkgs.legacyPackages."${system}".callPackage) callPackage;
          inherit directory;
        }
    );

  exposeFormatter = forEachSystem (system: inputs.nixpkgs.legacyPackages."${system}".alejandra);

  mkPkgs = pkgs: overlays:
    forEachSystem (system:
      import pkgs {
        inherit overlays system;
        config.allowUnfree = true;
        config.hardware.allowUnfree = true;
      });

  importRecursive = dir: let
    entries = lib.filesystem.listFilesRecursive dir;
    shouldIgnore = path: lib.hasPrefix "_" (lib.last (builtins.split "/" (builtins.toString path)));
  in
    if (builtins.pathExists dir)
    then
      builtins.map
      (entry: (import entry))
      (builtins.filter (entry: (lib.hasSuffix ".nix" entry) && !(shouldIgnore entry)) entries)
    else [];

  mkProfiles = dir: let
    entries = builtins.readDir dir;

    importEntry = name: type:
      if type == "regular" && lib.hasSuffix ".nix" name
      then import (dir + "/${name}")
      else if type == "directory"
      then mkProfiles (dir + "/${name}")
      else {};

    mkAttr = name: type:
      lib.nameValuePair (lib.removeSuffix ".nix" name) (importEntry name type);
  in
    lib.mapAttrs' mkAttr entries;

  mkHomes = dir: pkgs: let
    entries = builtins.readDir dir;
    subdirs = lib.filterAttrs (_: type: type == "directory") entries;
    withHome = lib.filterAttrs (name: _: builtins.pathExists (dir + "/${name}/home.nix")) subdirs;
  in
    lib.mapAttrs
    (name: _:
      import (dir + "/${name}/home.nix") {
        inherit lib pkgs;
        profiles = mkProfiles (dir + "/${name}/profiles");
      })
    withHome;

  mkLinux = hostDir: hostname: let
    config = import "${hostDir}/${hostname}/_config.nix" {};
    pkgs = (mkPkgs inputs.nixpkgs (mkOverlays config.system)).${config.system};
  in
    lib.nixosSystem {
      inherit pkgs;
      inherit (config) system;
      specialArgs = {inherit configDir homesDir inputs;};
      specialArgs.profiles = mkProfiles "${profilesDir}";
      modules = lib.flatten [
        {networking.hostName = hostname;}
        (lib.optional
          config.withAge
          age)
        (lib.optional
          config.withDisko
          disko)
        (lib.optional
          config.withHome
          home-manager)
        (lib.optional
          config.withHome
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit configDir;
              };
              users = mkHomes "${homesDir}" pkgs;
            };
          })
        (lib.optional
          config.withImpermanence
          impermanence)
        (lib.optional
          config.withLanzaboote
          lanzaboote)
        (importRecursive "${hostDir}/${hostname}")
        (importRecursive "${modulesDir}")
      ];
    };

  map = {
    directory,
    fn,
  }: let
    hostList = dirEntries: lib.attrsets.filterAttrs (_: value: value == "directory") dirEntries;
  in
    lib.attrsets.mapAttrs (name: _: (fn directory name)) (hostList (builtins.readDir directory));

  mkOverlays = system: [
    (final: prev: {
      vasco = (exposePackages {}).${system};
      unstable = (mkPkgs inputs.unstable []).${system};
      latest = (mkPkgs inputs.latest []).${system};
      final =
        final
        // {
          inherit
            (prev.lixPackageSets.stable)
            colmena
            nix-direnv
            nix-eval-jobs
            nix-fast-build
            nixpkgs-review
            ;
        };
      inherit lib;
    })
    inputs.nur.overlays.default
    inputs.agenix.overlays.default
  ];

  mkHomeManager = homeDir: userName: let
    modules = importRecursive "${homeDir}/${userName}/modules";
    profiles = mkProfiles "${homeDir}/${userName}/profiles";
    entryPoint = let
      homeFile = homeDir + "/${userName}/home.nix";
    in
      if (builtins.pathExists homeFile)
      then (import homeFile)
      else {};
  in
    forEachSystem (system:
      homeManagerConfiguration {
        pkgs = mkPkgs inputs.nixpkgs system (mkOverlays system);
        modules = modules ++ [entryPoint];
        extraSpecialArgs = {inherit configDir inputs profiles;};
      });
in {
  inherit
    map
    forEachSystem
    importRecursive
    mkHomeManager
    mkHomes
    mkLinux
    mkOverlays
    mkPkgs
    mkProfiles
    exposePackages
    exposeFormatter
    ;
}
