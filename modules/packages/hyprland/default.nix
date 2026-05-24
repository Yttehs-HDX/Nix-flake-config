# Hyprland package definition
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "hyprland";

  # Metadata - Linux desktop user package
  metadata = presets.linuxDesktopUser "desktop-session";

  # Backend implementation references
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
      home = null; # Not supported on Darwin
      system = null;
    };
  };
}
