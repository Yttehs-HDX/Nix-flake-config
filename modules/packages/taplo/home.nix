{ input, ... }:
{ pkgs, lib, ... }: {
  home.packages = [ pkgs.taplo ];

  programs.zsh.initContent =
    lib.optionalString (input.current.user.preferences.shell == "zsh") ''
      eval "$(taplo completions zsh)"
    '';
}
