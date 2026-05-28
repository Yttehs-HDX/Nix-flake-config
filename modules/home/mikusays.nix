{ pkgs, inputs, ... }: {
  home.packages = [
    inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.zerozawa.mikusays
  ];
}
