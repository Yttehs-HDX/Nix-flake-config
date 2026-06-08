{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.catppuccin-cursors.mochaLavender ];

  environment.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-lavender-cursors";
    XCURSOR_SIZE = "24";
  };

  # Expose to the display manager so SDDM sees the cursor.
  # XCURSOR_PATH is required — without it, Qt/Wayland won't know
  # where to find the cursor theme even if XCURSOR_THEME is set.
  systemd.services.display-manager.environment = {
    XCURSOR_THEME = "catppuccin-mocha-lavender-cursors";
    XCURSOR_SIZE = "24";
    XCURSOR_PATH = "${pkgs.catppuccin-cursors.mochaLavender}/share/icons";
  };
}
