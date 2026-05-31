{ pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.system;
    config.allowUnfree = true;
  };
in
{
  home.packages = [ unstable.pi-coding-agent ];
}
