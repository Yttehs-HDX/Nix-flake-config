{ pkgs, ... }:

let
  icat = pkgs.writeShellScriptBin "icat" ''
    exec ${pkgs.kitty}/bin/kitten icat "$@"
  '';
in {
  home.packages = [ icat ];

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14.0;
    };

    shellIntegration = {
      mode = "no_cursor";
      enableZshIntegration = true;
    };

    settings = {
      background_opacity = 0.9;
      background_blur = 1;
      remember_window_size = false;
    };
  };
}
