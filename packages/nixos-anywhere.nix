{pkgs, ...}:
pkgs.nixos-anywhere.overrideAttrs (self:
    self
    // {
      patches = [../patches/01-pre-post-install-hooks.path];
    })
