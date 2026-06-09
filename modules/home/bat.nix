{ pkgs, ... }:

{
  programs.bat.enable = true;
  home.sessionVariables.PAGER = "${pkgs.bat}/bin/bat";
}
