{ pkgs, ... }:

let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      grimblast
      swappy
    ];
    text = ''
      grimblast --freeze save area - | swappy -f -
    '';
  };
in
{
  home.packages = [ screenshot ];
}
