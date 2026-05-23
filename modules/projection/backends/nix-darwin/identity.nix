{ input }:
{ lib, ... }:
let description = import ../../common/identity-helpers.nix { inherit input; };
in {
  users.knownUsers = [ input.identity.name ];

  users.users.${input.identity.name} = {
    name = input.identity.name;
    createHome = true;
    description = description;
    home = input.identity.homeDirectory;
  } // lib.optionalAttrs (input.identity.uid != null) {
    uid = input.identity.uid;
  };
}
