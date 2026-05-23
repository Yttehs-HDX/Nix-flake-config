{ input }:
let homeModule = import ./home.nix { inherit input; };
in {
  systemModules = [ ];
  inherit homeModule;
  homeModules = { ${input.identity.name} = [ homeModule ]; };
}
