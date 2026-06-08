# Nix Flake Config

[![CI](https://img.shields.io/github/actions/workflow/status/Yttehs-HDX/nix-flake-config/ci.yml?branch=main&style=for-the-badge&label=CI)](https://github.com/Yttehs-HDX/nix-flake-config/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-0b7285?style=for-the-badge)](LICENSE)
[![Nix](https://img.shields.io/badge/Nix-Config-5277C3?logo=nixos&logoColor=white&style=for-the-badge)](https://nixos.org/)
[![Flake](https://img.shields.io/badge/Nix-Flake-2F855A?style=for-the-badge)](https://nixos.wiki/wiki/Flakes)

A personal Nix flake configuration for declaratively managing NixOS and Home Manager.

## Structure

```
├── flake.nix
├── hosts/nixos/<hostname>/
├── home/<username>/
├── modules/
│   ├── nixos/
│   │   └── desktop/
│   └── home/
│       ├── desktop/
│       └── theme/
└── docs/
```

## Documentation

- [docs/](docs/) — 使用教程

## Usage

```bash
# Build and switch the NixOS configuration
sudo nixos-rebuild switch --flake .

# Build and switch the Home Manager configuration
home-manager switch --flake .
```

## Third-Party Flake Inputs

| Input | Purpose |
| --- | --- |
| [nixpkgs](https://github.com/NixOS/nixpkgs) | Stable package set (nixos-26.05) |
| [nixpkgs-unstable](https://github.com/NixOS/nixpkgs) | Unstable package set for selected packages |
| [home-manager](https://github.com/nix-community/home-manager) | Home Manager modules and standalone builder |
| [nix-darwin](https://github.com/nix-darwin/nix-darwin) | macOS system builder (currently unused) |
| [nixvim](https://github.com/nix-community/nixvim) | Declarative Neovim configuration |
| [NUR](https://github.com/nix-community/NUR) | Community package repository |
| [Hexecute](https://github.com/ThatOtherAndrew/Hexecute) | Third-party package |
## Acknowledgements

Some configurations are based on [Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS).

## License

This project is licensed under the [MIT](LICENSE) license.
