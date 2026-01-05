{...}: {
  imports = [
    ./acme.nix
  ];

  services.nginx.enable = true;
  users.users.nginx.extraGroups = ["acme"];
}
