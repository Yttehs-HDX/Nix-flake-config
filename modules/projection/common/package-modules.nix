{ lib, input, backendType, scope, backendScope ? scope }:
let
  packageDefinitions = import ../../packages { inherit lib; };
  packageSet = input.packages.${scope} or { };

  resolve = packageId: definition:
    if builtins.hasAttr packageId packageDefinitions then
      let
        backendDef =
          builtins.getAttr backendType packageDefinitions.${packageId}.backends;
        backendPath = backendDef.${backendScope} or null;
      in if backendPath == null then
        ({ ... }: { })
      else
        (import backendPath) { inherit input definition; }
    else
      throw
      "Unsupported package `${packageId}` for backend `${backendType}` and scope `${scope}` on `${
        input.relationId or input.hostId
      }`.";
in map (packageId: resolve packageId packageSet.${packageId})
(lib.sort lib.lessThan (builtins.attrNames packageSet))
