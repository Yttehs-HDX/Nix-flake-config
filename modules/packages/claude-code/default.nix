# claude-code package definition
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "claude-code";

  metadata = presets.crossPlatformUserPackage "integration-heavy";

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
      system = ./darwin.nix;
    };
  };
}
