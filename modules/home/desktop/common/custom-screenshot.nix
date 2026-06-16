{ pkgs, ... }:

let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = [
      pkgs.grim
      pkgs.slurp
      pkgs.swappy
    ];
    text = ''
      grim -g "$(slurp)" - | swappy -f -
    '';
  };
in
{
  home.packages = [ screenshot ];
}
