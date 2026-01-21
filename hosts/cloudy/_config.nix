{...}: {
  system = "x86_64-linux";
  age.enable = true;
  disko = {
    enable = true;
    config = "cloudyDisk";
  };
  home.enable = false;
  impermanence.enable = true;
  secureboot = {
    enable = true;
    generateKeys = true;
  };
}
