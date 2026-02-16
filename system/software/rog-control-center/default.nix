{ config, lib, pkgs, hostname, ... }:

let
  mkSystemSoftware = import ../_lib/mkSystemSoftwareModule.nix {
    inherit lib config hostname;
    name = "rog-control-center";
  };
  inner = import ./inner.nix { };
in mkSystemSoftware inner
