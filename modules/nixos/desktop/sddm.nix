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
  themeId = "catppuccin-${theme.flavor}-${theme.accent}";
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    theme = "${catppuccin-sddm}/share/sddm/themes/${themeId}";
  };

  environment.systemPackages = [ catppuccin-sddm ];
}
