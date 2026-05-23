{ ... }:
{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in { home.packages = [ unstablePkgs.keepassxc ]; }
