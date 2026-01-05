{...}: {
  system = "x86_64-linux";
  age.enable = true;
  home.enable = true;
  impermanence.enable = true;
  secureboot = {
    enable = true;
    generateKeys = false;
  };
}
