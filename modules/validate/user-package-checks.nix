{ lib, normalized, packageCatalog, enabledPackageIds }:
lib.mapAttrsToList (userId: user:
  let
    invalidPackages = lib.filter
      (packageId: !packageCatalog.isReachableFromSource "home" "user" packageId)
      (enabledPackageIds user.packages);
  in if invalidPackages == [ ] then
    true
  else
    throw ''
      User `${userId}` must not declare `${
        lib.concatStringsSep "`, `"
        (map (packageId: "packages.${packageId}") invalidPackages)
      }`.
      These packages are host-controlled and must be declared under `profile.hosts.<hostId>.packages`.
    '') normalized.users
