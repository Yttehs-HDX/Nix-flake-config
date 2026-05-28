{ pkgs, ... }:

{
  gtk = {
    enable = true;

    gtk2.force = true;

    colorScheme = "dark";

    theme = {
      name = "catppuccin-mocha-lavender-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "compact";
        variant = "mocha";
      };
    };

    font = {
      name = "SF Pro";
      size = 12;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "catppuccin-mocha-lavender-cursors";
      package = pkgs.catppuccin-cursors.mochaLavender;
      size = 24;
    };
  };
}
