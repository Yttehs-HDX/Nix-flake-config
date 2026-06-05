{ ... }:

{
  imports = [
    ./default.nix

    ../../modules/home/fcitx5.nix
    ../../modules/home/desktop/niri
    ../../modules/home/theme/catppuccin-mocha
  ];
}
