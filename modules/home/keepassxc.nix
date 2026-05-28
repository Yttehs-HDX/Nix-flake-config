{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  home.packages = [ unstable.keepassxc ];
}
