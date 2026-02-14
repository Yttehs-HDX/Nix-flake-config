{ config, lib, pkgs, username, ... }:

let
  mkSoftware = import ../_lib/mkSoftwarePackage.nix {
    inherit lib config username;
    name = "hmcl";
  };
  inner = import ./inner.nix { inherit pkgs; };
in mkSoftware inner
