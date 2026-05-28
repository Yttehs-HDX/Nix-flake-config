{ inputs, ... }:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/zsh.nix
    ../../modules/home/nvim.nix
    ../../modules/home/kitty.nix
    ../../modules/home/xdg.nix
    ../../modules/home/tmux.nix
    ../../modules/home/btop.nix
    ../../modules/home/cava.nix
    ../../modules/home/openclaw.nix
    ../../modules/home/ocr.nix
    ../../modules/home/clash-verge.nix

    ./cli.nix
    ./dev.nix
    ./linux.nix
    ./unstable.nix
    ./flake-packages.nix
  ];

  home.username = "shetty";
  home.homeDirectory = "/home/shetty";

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
