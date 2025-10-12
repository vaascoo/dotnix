{pkgs, ...}:
pkgs.vimUtils.buildVimPlugin {
  pname = "referencer.nvim";
  version = "v0.0.1";
  src = pkgs.fetchFromGitHub {
    owner = "romus204";
    repo = "referencer.nvim";
    rev = "9348bf5761a4ffa762285737a36e05bf1846eb8a";
    sha256 = "sha256-DsdLicSxfML0PlyL5RH/U01MEo4KmjiAL44WgnbXUHY=";
  };
}
