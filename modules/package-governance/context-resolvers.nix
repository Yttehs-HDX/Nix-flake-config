# Context resolution helpers shared by rules.nix and diagnostics.nix.
#
# Extracted to break latent circular dependency: rules.nix imports taxonomy.nix,
# diagnostics.nix imports rules.nix, and context solvers were defined inside rules.nix.
# If rules.nix ever needed diagnostics.nix (e.g., structured error formatting),
# a cycle would result. Co-residing here eliminates that risk.
{ lib }:
let taxonomy = import ./taxonomy.nix;
in {
  # Current always has the canonical instance shape:
  #   { backend, host, user, relation, scopes, effectiveCapabilities, ... }
  resolveBackendType = current: current.backend.type;

  resolveHostPlatform = current: current.host.platform.system;

  resolveDesktopEnabled = scope: current:
    if scope == "system" then
      current.host.capabilities.desktop.enable
    else
      current.effectiveCapabilities.desktop.enable;

  resolvePlatformLabel = current:
    let platformSystem = current.host.platform.system;
    in if lib.hasSuffix "-darwin" platformSystem then
      "darwin"
    else if lib.hasSuffix "-linux" platformSystem then
      "linux"
    else
      platformSystem;
}
