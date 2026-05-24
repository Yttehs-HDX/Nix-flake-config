# udisks2 package definition
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "udisks2";

  metadata = presets.linuxDesktopUser "service";

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
