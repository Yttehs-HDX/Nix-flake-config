# 7-zip package definition (includes both p7zip and 7zz)
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "7-zip";

  metadata = presets.crossPlatformUserPackage "package";

  backends = {
    home-manager = {
      home = ./home.nix;
      system = null;
    };
    nixos = {
      home = ./home.nix;
      system = null;
    };
    nix-darwin = {
      home = ./home.nix;
      system = null;
    };
  };
}
