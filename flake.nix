{
  description = "Layered Nix flake config for Shetty";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hexecute = {
      url = "github:ThatOtherAndrew/Hexecute";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openclaw = {
      url = "github:openclaw/nix-openclaw";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      entrypoints = import ./modules/entrypoints { inherit inputs; };
      systems = [ "x86_64-linux" ];
      forAllSystems = lib.genAttrs systems;
    in {
      lib = {
        profile = entrypoints.profile;
        pipeline = entrypoints.pipeline;
      };

      nixosConfigurations = entrypoints.nixosConfigurations;
      darwinConfigurations = entrypoints.darwinConfigurations;
      homeConfigurations = entrypoints.homeConfigurations;

      checks = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          tests = import ./tests/default.nix {
            inherit lib inputs system;
            profile = entrypoints.profile;
            pipeline = entrypoints.pipeline;
            nixosConfigurations = entrypoints.nixosConfigurations;
            darwinConfigurations = entrypoints.darwinConfigurations;
            homeConfigurations = entrypoints.homeConfigurations;
          };
        in {
          architecture = builtins.seq tests
            (pkgs.runCommand "nix-flake-config-checks" { } ''
              touch "$out"
            '');
        });
    };
}
