# blueman package definition
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "blueman";

  metadata = presets.linuxDesktopHost "desktop-component";

  backends = {
    home-manager = {
      home = ./home.nix;
      system = null;
    };
    nixos = {
      home = ./home.nix;
      system = ./nixos.nix;
    };
    nix-darwin = {
      home = ./home.nix;
      system = null;
    };
  };
}
