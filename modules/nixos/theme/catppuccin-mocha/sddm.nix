{ pkgs, ... }:

let
  theme = {
    flavor = "mocha";
    accent = "lavender";
  };

  catppuccin-sddm = pkgs.catppuccin-sddm.override {
    inherit (theme) flavor;
    inherit (theme) accent;
  };

  cursorTheme = "catppuccin-mocha-lavender-cursors";

  themeId = "catppuccin-${theme.flavor}-${theme.accent}";
in
{
  services.displayManager.sddm = {
    theme = "${catppuccin-sddm}/share/sddm/themes/${themeId}";

    settings = {
      Theme = {
        CursorTheme = cursorTheme;
        CursorSize = 24;
      };
    };
  };

  environment.systemPackages = [ catppuccin-sddm ];
}
