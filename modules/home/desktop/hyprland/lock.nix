{ config, pkgs, ... }:

let
  swaylockThemed = pkgs.writeShellApplication {
    name = "swaylock-themed";
    runtimeInputs = [ config.programs.swaylock.package ];
    text = ''
      exec ${pkgs.lib.getExe config.programs.swaylock.package} "$@"
    '';
  };
in {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

  home.packages = [ swaylockThemed ];
}
