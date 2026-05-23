# Package rule functions.
#
# Provides metadata lookup, visibility governance, host-kind checks,
# target support checks, and full runtime support resolution.
#
# Functions are ordered by understanding flow:
#   1. Metadata lookup
#   2. Visibility / declaration legality
#   3. Support checks
{ lib }:
let
  taxonomy = import ./taxonomy.nix;
  catalog = {
    home = import ./catalog/home.nix { inherit lib; };
    system = import ./catalog/system.nix { inherit lib; };
  };
  resolvers = import ./context-resolvers.nix { inherit lib; };
  inherit (resolvers)
    resolveBackendType resolveHostPlatform resolveDesktopEnabled
    resolvePlatformLabel;

  # Restrictive fallback for packages not registered in the queried catalog.
  # Produces a record that blocks the package on the queried scope.
  # Only emits a trace warning when the package is absent from ALL catalogs.
  # Does NOT set `owner` so ownerFor can apply the scope-based default.
  unregisteredFallback = scope: packageId:
    let
      existsInAnyCatalog = builtins.hasAttr packageId catalog.home
        || builtins.hasAttr packageId catalog.system;
      result = {
        kind = "package";
        allowedHostKinds = [ ];
        allowedTargets = [ ];
        requiresDesktop = false;
        missingStrategy = taxonomy.missingStrategies.error;
      };
    in if existsInAnyCatalog then
      result
    else
      builtins.trace
      "WARNING: Package '${packageId}' is not registered in any catalog. It will be excluded from all targets. Ensure it has a definition under modules/packages/${packageId}/default.nix and that its metadata.allowedTargets includes the relevant ${scope} scope/targets."
      result;

  # ── 2. Metadata lookup ────────────────────────────────────────────────

  hasEntryFor = scope: packageId: builtins.hasAttr packageId catalog.${scope};

  metadataFor = scope: packageId:
    if hasEntryFor scope packageId then
      catalog.${scope}.${packageId}
    else
      unregisteredFallback scope packageId;

  ownerFor = scope: packageId:
    let metadata = metadataFor scope packageId;
    in metadata.owner or (if scope == "system" then "host" else "user");

  # ── 3. Visibility / declaration legality ──────────────────────────────

  # Determines whether a package can be reached from a given
  # declaration source (user or host) in a given scope.
  isReachableFromSource = scope: declaredBy: packageId:
    if ownerFor scope packageId != declaredBy then
      false
    else if scope == "home" then
      if declaredBy == "host" then hasEntryFor "home" packageId else true
    else if scope == "system" then
      hasEntryFor "system" packageId || !hasEntryFor "home" packageId
    else
      false;

  # ── 4. Support checks ────────────────────────────────────────────────

  allowedOnHostKind = scope: hostKind: packageId:
    let metadata = metadataFor scope packageId;
    in builtins.elem hostKind
    (metadata.allowedHostKinds or taxonomy.allHostKinds);

  supportsTarget = scope: target: packageId:
    let metadata = metadataFor scope packageId;
    in builtins.elem target (metadata.allowedTargets or [ ]);

  # Convenience: check support by backend type and scope.
  # Resolves the target from backend + scope, then checks allowedTargets.
  supportsBackend = scope: backend: packageId:
    let
      target = taxonomy.resolveTarget backend scope;
      metadata = metadataFor scope packageId;
    in builtins.elem target (metadata.allowedTargets or [ ]);

  # Full runtime support check.
  # Returns true only when the package is allowed on the current
  # host kind, supported on the resolved target, and any desktop
  # requirement is satisfied.
  supportedFor = scope: current: packageId:
    let
      metadata = metadataFor scope packageId;
      currentBackend = resolveBackendType current;
      hostKind = if currentBackend != null then
        taxonomy.backendToHostKind.${currentBackend} or null
      else
        null;
      target = if currentBackend != null then
        taxonomy.resolveTarget currentBackend scope
      else
        null;
    in (hostKind != null
      && builtins.elem hostKind (metadata.allowedHostKinds or [ ]))
    && (target != null && builtins.elem target (metadata.allowedTargets or [ ]))
    && (!(metadata.requiresDesktop or false)
      || resolveDesktopEnabled scope current);

in {
  inherit hasEntryFor metadataFor ownerFor isReachableFromSource
    allowedOnHostKind supportsTarget supportsBackend supportedFor;

  # Exported for diagnostics module.
  inherit resolveBackendType resolveHostPlatform resolveDesktopEnabled
    resolvePlatformLabel;
}
