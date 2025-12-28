{...}: {
  nix = {
    gc = {
      automatic = true;
      options = "-d";
      dates = "weekly";
      randomizedDelaySec = "4h";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
      randomizedDelaySec = "4h";
    };
  };
}
