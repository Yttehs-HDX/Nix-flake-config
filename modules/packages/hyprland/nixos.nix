{ definition, ... }:
{ ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = definition.settings.withUWSM or false;
    xwayland.enable = definition.settings.xwaylandEnable or true;
  };
}
