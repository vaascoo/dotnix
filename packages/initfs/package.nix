{pkgs, ...}:
pkgs.buildGoModule {
  pname = "initfs";
  version = "0.0.1";
  src = ./.;
  vendorHash = "sha256-yhTCPQtVclzE8lhNNXsGfJiSxLUvGGhGgMG4xaTXlZY=";
  env.CGO_ENABLED = 0;

  meta = {
    description = "Manage yout initrdfs";
    mainProgram = "initfs";
    homepage = "https://github.com/vaascoo/nix";
    license = pkgs.lib.licenses.gpl3;
    maintainers = [];
  };
}
