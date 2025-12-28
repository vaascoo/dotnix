{profiles, ...}: {
  imports = with profiles.system; [
    age
    common
    doh
    gc
    hwAccel
    keymap
    tailscale
    virt
    wayland
    zfs
  ];

  # missing bootloader

  networking.hostId = "ba519675";
  system.stateVersion = "25.11";
}
