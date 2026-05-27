# gvfs package definition
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "gvfs";

  metadata = presets.linuxDesktopUser "service";

  backends = {
    home-manager = {
      home = null;
      system = null;
    };
    nixos = {
      home = null;
      system = ./nixos.nix;
    };
    nix-darwin = {
      home = null;
      system = null;
    };
  };
}
