{ ... }:

{
  imports = [
    ./default.nix

    ../../modules/home/fcitx5.nix
    ../../modules/home/desktop/hyprland
    ../../modules/home/theme/catppuccin-mocha
  ];
}
