{ lib, normalized, packageCatalog, enabledPackageIds }:
let taxonomy = import ../package-governance/taxonomy.nix;
in lib.mapAttrsToList (hostId: host:
  let
    backendType = host.backend.type;
    platformSystem = host.platform.system;
    stateVersion = host.system.stateVersion;
    expectedSystemScope = taxonomy.hasSystemScope backendType;
    expectedHomeScope = taxonomy.hasHomeScope backendType;
    invalidPackages = lib.filter (packageId:
      !(host.capabilities.home.enable
        && packageCatalog.isReachableFromSource "home" "host" packageId
        && packageCatalog.supportsBackend "home" backendType packageId)
      && !(host.capabilities.system.enable
        && packageCatalog.isReachableFromSource "system" "host" packageId))
      (enabledPackageIds host.packages);
  in if !host.enable then
    true
  else if platformSystem == null then
    throw "Enabled host `${hostId}` must declare `platform.system`."
  else if !(taxonomy.backendPlatformMatches backendType platformSystem) then
    throw
    "Host `${hostId}` must use a `platform.system` compatible with backend `${backendType}`."
  else if host.capabilities.system.enable != expectedSystemScope then
    throw
    "Host `${hostId}` must keep `capabilities.system.enable` consistent with backend `${backendType}`."
  else if host.capabilities.home.enable != expectedHomeScope then
    throw
    "Host `${hostId}` must keep `capabilities.home.enable` consistent with backend `${backendType}`."
  else if invalidPackages != [ ] then
    throw ''
      Host `${hostId}` must not declare `${
        lib.concatStringsSep "`, `"
        (map (packageId: "packages.${packageId}") invalidPackages)
      }`.
      Host packages may only contain system packages or host-controlled home packages.
    ''
  else if backendType == "nixos" && stateVersion == null then
    throw "NixOS host `${hostId}` must declare `system.stateVersion`."
  else if backendType == "nixos" && !(builtins.isString stateVersion) then
    throw
    "NixOS host `${hostId}` must declare `system.stateVersion` as a string."
  else if backendType == "nix-darwin" && stateVersion == null then
    throw "nix-darwin host `${hostId}` must declare `system.stateVersion`."
  else if backendType == "nix-darwin" && !(builtins.isInt stateVersion) then
    throw
    "nix-darwin host `${hostId}` must declare `system.stateVersion` as an integer."
  else if !(taxonomy.hasSystemScope backendType) && stateVersion != null then
    throw
    "Host `${hostId}` must not declare `system.stateVersion` without system scope."
  else
    true) normalized.hosts
