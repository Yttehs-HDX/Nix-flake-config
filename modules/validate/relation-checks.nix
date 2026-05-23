{ lib, normalized, enabledRelations }:
let
  taxonomy = import ../package-governance/taxonomy.nix;

  relationSystemOnlyFields = relation:
    (lib.optional (relation.identity.uid != null) "identity.uid")
    ++ (lib.optional (relation.membership.primaryGroup != null)
      "membership.primaryGroup")
    ++ (lib.optional (relation.membership.extraGroups != [ ])
      "membership.extraGroups");

  relationUnsupportedFields = host: relation:
    let
      backendType = host.backend.type;
      systemOnlyFields = if host.capabilities.system.enable then
        [ ]
      else
        relationSystemOnlyFields relation;
      darwinUnsupportedFields = (lib.optional (backendType == "nix-darwin"
        && relation.membership.primaryGroup != null) "membership.primaryGroup")
        ++ (lib.optional (backendType == "nix-darwin"
          && relation.membership.extraGroups != [ ]) "membership.extraGroups");
    in lib.unique (systemOnlyFields ++ darwinUnsupportedFields);

  relationStateChecks = lib.mapAttrsToList (relationId: relation:
    let host = normalized.hosts.${relation.host};
    in if relation.enable && host.capabilities.home.enable
    && relation.state.home.stateVersion == null then
      throw
      "Relation `${relationId}` must declare `state.home.stateVersion` for home scope."
    else
      true) enabledRelations;

  relationScopeChecks = lib.mapAttrsToList (relationId: relation:
    let
      host = normalized.hosts.${relation.host};
      unsupportedFields = relationUnsupportedFields host relation;
    in if relation.enable && unsupportedFields != [ ] then
      throw "Relation `${relationId}` must not declare `${
        lib.concatStringsSep "`, `" unsupportedFields
      }` for backend `${host.backend.type}`."
    else
      true) enabledRelations;
in relationStateChecks ++ relationScopeChecks
