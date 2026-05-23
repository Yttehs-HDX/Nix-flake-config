{ lib, pipeline }:
lib.mapAttrs (relationId: input:
  let
    backendProjection =
      import ./backends/${input.backend.type}/default.nix { inherit input; };
  in backendProjection // {
    inherit relationId;
    hostId = input.hostId;
    userId = input.userId;
    identityName = input.identity.name;
    backend = input.backend;
    scopes = input.scopes;
    platformSystem = input.current.host.platform.system;
    hostHardwareModules = input.current.host.hardware.modules or [ ];
  }) pipeline.projectionInputs
