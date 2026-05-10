# Nix Flake Config

[English](README.md) | [简体中文](README.cn.md)

[![CI](https://img.shields.io/github/actions/workflow/status/Yttehs-HDX/nix-flake-config/ci.yml?branch=main&style=for-the-badge&label=CI)](https://github.com/Yttehs-HDX/nix-flake-config/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-0b7285?style=for-the-badge)](LICENSE)
[![Nix](https://img.shields.io/badge/Nix-Config-5277C3?logo=nixos&logoColor=white&style=for-the-badge)](https://nixos.org/)
[![Flake](https://img.shields.io/badge/Nix-Flake-2F855A?style=for-the-badge)](https://nixos.wiki/wiki/Flakes)
[![Platforms](https://img.shields.io/badge/Platforms-NixOS%20%7C%20nix--darwin%20%7C%20Home%20Manager-374151?style=for-the-badge)](#)

A layered Nix flake configuration repository built around a unified declarative model.

This repository projects the same user, host, and software intent into multiple host and operating-system backends, including NixOS, nix-darwin, and Home Manager. By separating stable semantics from backend-specific adaptation, it reduces duplicated configuration, preserves cross-platform consistency, and keeps platform differences localized to projection layers.

## First-Class Elements
The repository is centered around four first-class elements:
- **users**: long-lived user semantics and preferences
- **hosts**: host identity, capabilities, and system boundaries
- **relations**: bindings between users and hosts; the sole entry point for instantiation
- **packages**: a unified abstraction for software intent across packages, programs, and services

## Design
This is not a traditional host-file-oriented Nix configuration repository.  
Instead, it separates declaration from derived results, and uses explicit boundaries to keep the system extensible, composable, and maintainable over time.

## Documentation
Start here for architecture and design details:
- [docs/README.md](docs/README.md)

## Third-Party Nix Modules and Libraries

| Name | Type | Where Used | Purpose |
| --- | --- | --- | --- |
| [nixpkgs](https://github.com/NixOS/nixpkgs) | Flake input / package set | `flake.nix`, `modules/assembly/nixos.nix`, `modules/assembly/darwin.nix` | Provides package set, `lib`, and NixOS system builder. |
| [nix-darwin](https://github.com/nix-darwin/nix-darwin) | Flake input / Darwin system library | `flake.nix`, `modules/assembly/darwin.nix` | Provides macOS (`nix-darwin`) system builder. |
| [home-manager](https://github.com/nix-community/home-manager) | Flake input / Nix module library | `flake.nix`, `modules/assembly/nixos.nix`, `modules/assembly/darwin.nix`, `modules/assembly/home-manager.nix` | Provides Home Manager modules and standalone Home Manager configuration builder. |
| [nixvim](https://github.com/nix-community/nixvim) | Flake input / Home Manager module | `flake.nix`, `modules/packages/nixvim/home.nix` | Imports `nixvim` Home Manager module to declare Neovim configuration declaratively. |
| [NUR](https://github.com/nix-community/NUR) | Flake input / package source | `flake.nix`, `modules/projection/common/package-sources.nix`, `modules/packages/mikusays/home.nix` | Provides third-party package source (for example `mikusays`). |
| [Hexecute](https://github.com/ThatOtherAndrew/Hexecute) | Flake input / package source | `flake.nix`, `modules/projection/common/package-sources.nix`, `modules/packages/hexecute/home.nix` | Provides third-party package source (`hexecute`). |
| [nix-openclaw](https://github.com/openclaw/nix-openclaw) | Flake input / Home Manager module + package source | `flake.nix`, `modules/projection/common/package-sources.nix`, `modules/packages/openclaw/home.nix` | Provides the `openclaw` Home Manager module (`programs.openclaw`) and package source. Installs OpenClaw and manages the `openclaw-gateway` systemd user service. |

Notes:
- "Nix module" here means entries imported through `imports = [ ... ]`.
- In this repository, direct third-party module imports are currently from `home-manager`, `nixvim`, and `nix-openclaw`; `NUR` and `Hexecute` are used as package sources only.

## Acknowledgements
Some configurations are based on [Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS).

## License
This project is licensed under the [MIT](LICENSE) license.
