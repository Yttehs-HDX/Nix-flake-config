{
  lib,
  ...
}:

let
  palette = import ./palette.nix;
in
{
  # Catppuccin Mocha theme overrides for niri.
  #
  # Niri config is written as KDL via xdg.configFile."niri/config.kdl".text
  # in the core desktop/niri/niri.nix module.  To customise the border colours
  # and other visuals, override that string with lib.mkForce using your own KDL
  # that incorporates the palette below.
  #
  # Palette reference (hex, no #):
  #   rosewater=${palette.rosewater}  flamingo=${palette.flamingo}
  #   pink=${palette.pink}            mauve=${palette.mauve}
  #   red=${palette.red}              maroon=${palette.maroon}
  #   peach=${palette.peach}          yellow=${palette.yellow}
  #   green=${palette.green}          teal=${palette.teal}
  #   sky=${palette.sky}              sapphire=${palette.sapphire}
  #   blue=${palette.blue}            lavender=${palette.lavender}
  #   text=${palette.text}            subtext1=${palette.subtext1}
  #   subtext0=${palette.subtext0}    overlay2=${palette.overlay2}
  #   overlay1=${palette.overlay1}    overlay0=${palette.overlay0}
  #   surface2=${palette.surface2}    surface1=${palette.surface1}
  #   surface0=${palette.surface0}    base=${palette.base}
  #   mantle=${palette.mantle}        crust=${palette.crust}
}
