{ config, lib, pkgs, hostname, ... }:

let
  mkSystemSoftware = import ../_lib/mkSystemSoftwareModule.nix {
    inherit lib config hostname;
    name = "supergfxctl";
  };
  inner = import ./inner.nix { inherit pkgs; };
in mkSystemSoftware inner
