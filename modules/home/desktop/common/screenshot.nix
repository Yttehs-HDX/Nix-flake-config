{ pkgs, ... }:

let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      grim
      slurp
      swappy
    ];
    text = ''
      grim -g "$(slurp)" - | swappy -f -
    '';
  };
in
{
  home.packages = [ screenshot ];
}
