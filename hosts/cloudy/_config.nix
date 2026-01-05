{...}: {
  system = "x86_64-linux";
  age.enable = true;
  disko = {
    enable = true;
    config = "sunnyDisk";
  };
  home.enable = false;
  impermanence.enable = true;
  secureboot = {
    enable = true;
    generateKeys = true;
  };
}
