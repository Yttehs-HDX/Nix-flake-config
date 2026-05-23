{ input, definition, ... }:
{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  passwordStore = definition.settings.passwordStore or null;
  obsidian = if passwordStore != null then
    unstablePkgs.symlinkJoin {
      name = "obsidian";
      paths = [ unstablePkgs.obsidian ];
      nativeBuildInputs = [ unstablePkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/obsidian \
          --add-flags "--password-store=${passwordStore}"
      '';
    }
  else
    unstablePkgs.obsidian;
in { home.packages = [ obsidian ]; }
