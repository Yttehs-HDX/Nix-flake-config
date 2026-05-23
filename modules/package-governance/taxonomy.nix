# Package classification taxonomy.
#
# Defines the coordinate system for host kinds, deployment targets,
# ownership, and missing-package strategies.
#
# This file is pure data — no function arguments, no lib dependency.
{
  # --- Host kinds ---
  hostKinds = {
    nixos = "nixos";
    darwin = "darwin";
    standaloneHomeManager = "standaloneHomeManager";
  };

  allHostKinds = [ "nixos" "darwin" "standaloneHomeManager" ];

  # --- Deployment targets (hostKind × scope) ---
  targets = {
    nixosHome = "nixosHome";
    nixosSystem = "nixosSystem";
    darwinHome = "darwinHome";
    darwinSystem = "darwinSystem";
    standaloneHomeManagerHome = "standaloneHomeManagerHome";
    standaloneHomeManagerSystem = "standaloneHomeManagerSystem";
  };

  allTargets = [
    "nixosHome"
    "nixosSystem"
    "darwinHome"
    "darwinSystem"
    "standaloneHomeManagerHome"
    "standaloneHomeManagerSystem"
  ];

  allHomeTargets = [ "nixosHome" "darwinHome" "standaloneHomeManagerHome" ];

  allSystemTargets =
    [ "nixosSystem" "darwinSystem" "standaloneHomeManagerSystem" ];

  # --- Ownership ---
  owners = {
    user = "user";
    host = "host";
  };

  missingStrategies = {
    notApplicable = "notApplicable";
    error = "error";
    skip = "skip";
    hintManual = "hintManual";
  };

  # --- Backend type → host kind mapping ---
  backendToHostKind = {
    nixos = "nixos";
    "nix-darwin" = "darwin";
    "home-manager" = "standaloneHomeManager";
  };

  # --- Resolve deployment target from backend type and scope ---
  resolveTarget = backend: scope:
    let
      mapping = {
        nixos = {
          home = "nixosHome";
          system = "nixosSystem";
        };
        "nix-darwin" = {
          home = "darwinHome";
          system = "darwinSystem";
        };
        "home-manager" = {
          home = "standaloneHomeManagerHome";
          system = "standaloneHomeManagerSystem";
        };
      };
    in if builtins.hasAttr backend mapping
    && builtins.hasAttr scope mapping.${backend} then
      mapping.${backend}.${scope}
    else
      throw "Unknown backend/scope combination: ${backend}/${scope}";

  # --- Scope resolution ---
  hasSystemScope = backendType:
    backendType == "nixos" || backendType == "nix-darwin";

  hasHomeScope = backendType:
    backendType == "nixos" || backendType == "home-manager" || backendType
    == "nix-darwin";

  backendPlatformMatches = backendType: platformSystem:
    if backendType == "nixos" then
      builtins.match ".*-linux" platformSystem != null
    else if backendType == "nix-darwin" then
      builtins.match ".*-darwin" platformSystem != null
    else
      true;
}
