{ config, ... }:

let palette = import ./palette.nix;
in {
  programs.rofi = {
    font = "SF Pro 12";
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        border-col = mkLiteral "@blue";
        bg-col = mkLiteral "${palette.base}bf";
        bg-col-light = mkLiteral "${palette.surface0}b3";
        fg-col = mkLiteral palette.text;
        highlight = mkLiteral palette.red;
        blue = mkLiteral palette.blue;
        accent = mkLiteral "${palette.lavender}cc";
        text = mkLiteral palette.overlay0;
        width = 800;
      };

      "element-text, element-icon , mode-switcher" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      window = {
        height = mkLiteral "480px";
        border = mkLiteral "2px";
        border-radius = mkLiteral "15px";
        border-color = mkLiteral "@border-col";
        background-color = mkLiteral "@bg-col";
      };

      mainbox = { background-color = mkLiteral "transparent"; };

      inputbar = {
        children = mkLiteral "[prompt,entry]";
        border-radius = mkLiteral "5px";
        background-color = mkLiteral "inherit";
        margin = mkLiteral "10px 10px 0px";
      };

      prompt = {
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@blue";
        text-color = mkLiteral "@bg-col";
        padding = mkLiteral "10px";
      };

      entry = {
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@bg-col";
        text-color = mkLiteral "@fg-col";
        padding = mkLiteral "13px 10px";
        margin = mkLiteral "0px 0px 0px 5px";
      };

      listview = {
        background-color = mkLiteral "inherit";
        columns = 3;
        margin = mkLiteral "10px 10px 0px";
      };

      element = {
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "@fg-col";
        padding = mkLiteral "10px";
      };

      "element selected" = {
        text-color = mkLiteral "@bg-col";
        background-color = mkLiteral "@accent";
      };

      element-icon = {
        border-radius = mkLiteral "10px";
        size = mkLiteral "32px";
        padding = mkLiteral "5px";
        margin = mkLiteral "0px 5px 0px 0px";
      };

      element-text = {
        border-radius = mkLiteral "10px";
        vertical-align = mkLiteral "0.5";
        text-color = mkLiteral "0.5";
        padding = mkLiteral "10px";
      };

      "element-text selected" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "inherit";
      };

      mode-switcher = { spacing = 0; };

      button = {
        background-color = mkLiteral "@bg-col-light";
        text-color = mkLiteral "@text";
        padding = mkLiteral "10px";
      };

      "button selected" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@blue";
      };

      message = {
        background-color = mkLiteral "inherit";
        margin = mkLiteral "10px 10px 0px";
      };

      textbox = {
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@bg-col";
        text-color = mkLiteral "@accent";
        padding = mkLiteral "10px";
      };
    };
  };
}
