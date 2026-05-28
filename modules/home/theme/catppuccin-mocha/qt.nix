{ pkgs, ... }:

let
  kvantumTheme = pkgs.catppuccin-kvantum.override {
    variant = "mocha";
    accent = "lavender";
  };
  themeName = "catppuccin-mocha-lavender";
in {
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/${themeName}".source =
      "${kvantumTheme}/share/Kvantum/${themeName}";
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${themeName}
    '';
  };
}
