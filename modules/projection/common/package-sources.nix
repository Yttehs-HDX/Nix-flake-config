{ pkgs, inputs }:
let
  system = pkgs.stdenv.hostPlatform.system;
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  homeCustomSources = {
    hexecute = inputs.hexecute.packages.${system}.default;
    mikusays = inputs.nur.legacyPackages.${system}.repos.zerozawa.mikusays;
    obsidian = unstablePkgs.obsidian;
    vscode = unstablePkgs.vscode;
    claude-code = unstablePkgs.claude-code;
  };
in {
  inherit system unstablePkgs homeCustomSources;

  getPackage = packageId:
    if builtins.hasAttr packageId homeCustomSources then
      homeCustomSources.${packageId}
    else
      builtins.getAttr packageId pkgs;

  hasCustomSource = packageId: builtins.hasAttr packageId homeCustomSources;
}
