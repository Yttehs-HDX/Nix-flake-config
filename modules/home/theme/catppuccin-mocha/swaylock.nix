{ lib, ... }:

let palette = import ./palette.nix;
in {
  programs.swaylock.settings = {
    screenshots = true;
    clock = true;
    font = "SF Pro";
    font-size = 64;
    text-color = lib.removePrefix "#" palette.lavender;
    text-caps-lock-color = lib.removePrefix "#" palette.pink;
    indicator = true;
    indicator-radius = 100;
    indicator-thickness = 7;
    effect-blur = "25x25";
    effect-vignette = "0.5:0.5";
    ring-color = lib.removePrefix "#" palette.lavender;
    key-hl-color = lib.removePrefix "#" palette.pink;
    line-color = "00000000";
    inside-color = "00000088";
    separator-color = "00000000";
  };
}
