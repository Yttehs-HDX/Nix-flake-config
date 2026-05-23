{ lib, enabledRelations }: {
  relationsByHost = lib.foldl' (acc: relation:
    acc // {
      ${relation.host} = (acc.${relation.host} or [ ])
        ++ [ relation.relationId ];
    }) { } (lib.attrValues enabledRelations);

  relationsByUser = lib.foldl' (acc: relation:
    acc // {
      ${relation.user} = (acc.${relation.user} or [ ])
        ++ [ relation.relationId ];
    }) { } (lib.attrValues enabledRelations);
}
