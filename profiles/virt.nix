{...}: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd.enable = true;
  };
  programs.virt-manager.enable = true;
}
