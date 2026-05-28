{ pkgs, ... }:

{
  programs = {
    direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    gh.enable = true;
  };

  home.packages = with pkgs; [ nodejs taplo ];
}
