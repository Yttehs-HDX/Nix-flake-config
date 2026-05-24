# Pipewire package definition
{ lib }:
let taxonomy = import ../../package-governance/taxonomy.nix;
in {
  packageId = "pipewire";

  metadata = {
    kind = "service";
    owner = taxonomy.owners.host;
    allowedHostKinds = [ "nixos" ];
    allowedTargets = [ taxonomy.targets.nixosHome ];
    requiresDesktop = false;
    missingStrategy = taxonomy.missingStrategies.hintManual;
    unsupportedReason =
      "This package currently relies on NixOS system integration and is not implemented on this backend.";
    unsupportedSuggestion =
      "Use a NixOS backend for automatic setup, or configure PipeWire manually on this host.";
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
