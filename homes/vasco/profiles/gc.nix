{...}: let
  gcOptions = {
    automatic = true;
    options = "-d";
    dates = "weekly";
    randomizedDelaySec = "4h";
  };
in {
  nix.gc = gcOptions;
}
