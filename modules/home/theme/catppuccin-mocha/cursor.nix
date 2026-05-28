{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-mocha-lavender-cursors";
    package = pkgs.catppuccin-cursors.mochaLavender;
    size = 24;
  };
}
