{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  home.packages = [
    (unstable.symlinkJoin {
      name = "obsidian";
      paths = [ unstable.obsidian ];
      nativeBuildInputs = [ unstable.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/obsidian \
          --add-flags "--password-store=gnome-libsecret"
      '';
    })
  ];
}
