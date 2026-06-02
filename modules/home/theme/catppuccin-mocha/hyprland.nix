{ lib, ... }:

let
  palette = import ./palette.nix;
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      # general = {
      #   "col.active_border" = "${rgba palette.mauve "ff"} ${rgba palette.rosewater "ff"} 45deg";
      #   "col.inactive_border" = "${rgba palette.lavender "cc"} ${rgba palette.overlay0 "cc"} 45deg";
      # };
    };

    # config.plugin = {
    #   hyprexpo = {
    #     bg_col = rgba palette.base "cc";
    #   };
    # };
  };
}
