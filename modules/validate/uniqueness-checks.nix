{ lib, normalized, enabledRelations }:
let
  resolveIdentityName = relation:
    if relation.identity.name != null then
      relation.identity.name
    else
      lib.toLower relation.user;

  relationPairs = map (relation: "${relation.user}@${relation.host}")
    (lib.attrValues enabledRelations);

  hostIdentityPairs =
    map (relation: "${relation.host}@${resolveIdentityName relation}")
    (lib.attrValues enabledRelations);

  relationIdChecks = lib.mapAttrsToList (relationId: relation:
    if relationId == "${relation.user}@${relation.host}" then
      true
    else
      throw
      "Relation `${relationId}` must match `${relation.user}@${relation.host}`.")
    normalized.relations;

  uniquenessCheck =
    if lib.length relationPairs == lib.length (lib.unique relationPairs) then
      true
    else
      throw "Enabled relations must be unique by user@host pair.";

  hostIdentityUniquenessCheck = if lib.length hostIdentityPairs
  == lib.length (lib.unique hostIdentityPairs) then
    true
  else
    throw "Enabled relations must resolve to unique usernames per host.";
in relationIdChecks ++ [ uniquenessCheck hostIdentityUniquenessCheck ]
