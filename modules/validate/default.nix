{ lib, normalized }:
let
  packageCatalog = import ../package-governance { inherit lib; };

  enabledPackageIds = definitions:
    builtins.attrNames (lib.filterAttrs (_: pkg: pkg.enable) definitions);

  enabledRelations =
    lib.filterAttrs (_: relation: relation.enable) normalized.relations;

  references = import ./references.nix { inherit lib normalized; };
  capabilities = import ./capabilities.nix { inherit lib normalized; };
  userPackageChecks = import ./user-package-checks.nix {
    inherit lib normalized packageCatalog enabledPackageIds;
  };
  hostChecks = import ./host-checks.nix {
    inherit lib normalized packageCatalog enabledPackageIds;
  };
  relationChecks =
    import ./relation-checks.nix { inherit lib normalized enabledRelations; };
  uniquenessChecks =
    import ./uniqueness-checks.nix { inherit lib normalized enabledRelations; };
  indexes = import ./index-builder.nix { inherit lib enabledRelations; };
in builtins.deepSeq ([
  references
  capabilities
  userPackageChecks
  hostChecks
  relationChecks
  uniquenessChecks
] ++ userPackageChecks ++ hostChecks ++ relationChecks
  ++ uniquenessChecks) { inherit indexes; }
