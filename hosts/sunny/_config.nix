{...}: {
  system = "x86_64-linux";
  age.enable = true;
  disko = {
    enable = true;
    config = "sunnyDisk";
  };
  home.enable = true;
  impermanence.enable = true;
  secureboot.enable = false;
}
