{ pkgs, inputs, ... }:

let system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = [
    inputs.hexecute.packages.${system}.default
    inputs.nur.legacyPackages.${system}.repos.zerozawa.mikusays
  ];
}
