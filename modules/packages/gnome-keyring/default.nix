# Gnome-keyring package definition
{ lib }:
let taxonomy = import ../../package-governance/taxonomy.nix;
in {
  packageId = "gnome-keyring";

  metadata = {
    kind = "service";
    owner = taxonomy.owners.user;
    allowedHostKinds = [ "nixos" ];
    allowedTargets = [ taxonomy.targets.nixosHome ];
    requiresDesktop = true;
    missingStrategy = taxonomy.missingStrategies.hintManual;
    unsupportedReason =
      "gnome-keyring requires NixOS system-level integration for proper PAM and D-Bus setup.";
    unsupportedSuggestion =
      "Use a NixOS backend for automatic gnome-keyring setup, or configure the service manually.";
  };

  # Phase 1: preserve legacy behavior (no projector output)
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
