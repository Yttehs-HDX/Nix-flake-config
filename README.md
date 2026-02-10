# Nix Flake Config
[![Nix Flake CI](https://github.com/Yttehs-HDX/NixOS-flake-config/actions/workflows/ci.yml/badge.svg)](https://github.com/Yttehs-HDX/NixOS-flake-config/actions/workflows/ci.yml)
[![zread](https://img.shields.io/badge/Ask_Zread-_.svg?style=flat&color=00b0aa&labelColor=000000&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB3aWR0aD0iMTYiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuOTYxNTYgMS42MDAxSDIuMjQxNTZDMS44ODgxIDEuNjAwMSAxLjYwMTU2IDEuODg2NjQgMS42MDE1NiAyLjI0MDFWNC45NjAxQzEuNjAxNTYgNS4zMTM1NiAxLjg4ODEgNS42MDAxIDIuMjQxNTYgNS42MDAxSDQuOTYxNTZDNS4zMTUwMiA1LjYwMDEgNS42MDE1NiA1LjMxMzU2IDUuNjAxNTYgNC45NjAxVjIuMjQwMUM1LjYwMTU2IDEuODg2NjQgNS4zMTUwMiAxLjYwMDEgNC45NjE1NiAxLjYwMDFaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00Ljk2MTU2IDEwLjM5OTlIMi4yNDE1NkMxLjg4ODEgMTAuMzk5OSAxLjYwMTU2IDEwLjY4NjQgMS42MDE1NiAxMS4wMzk5VjEzLjc1OTlDMS42MDE1NiAxNC4xMTM0IDEuODg4MSAxNC4zOTk5IDIuMjQxNTYgMTQuMzk5OUg0Ljk2MTU2QzUuMzE1MDIgMTQuMzk5OSA1LjYwMTU2IDE0LjExMzQgNS42MDE1NiAxMy43NTk5VjExLjAzOTlDNS42MDE1NiAxMC42ODY0IDUuMzE1MDIgMTAuMzk5OSA0Ljk2MTU2IDEwLjM5OTlaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik0xMy43NTg0IDEuNjAwMUgxMS4wMzg0QzEwLjY4NSAxLjYwMDEgMTAuMzk4NCAxLjg4NjY0IDEwLjM5ODQgMi4yNDAxVjQuOTYwMUMxMC4zOTg0IDUuMzEzNTYgMTAuNjg1IDUuNjAwMSAxMS4wMzg0IDUuNjAwMUgxMy43NTg0QzE0LjExMTkgNS42MDAxIDE0LjM5ODQgNS4zMTM1NiAxNC4zOTg0IDQuOTYwMVYyLjI0MDFDMTQuMzk4NCAxLjg4NjY0IDE0LjExMTkgMS42MDAxIDEzLjc1ODQgMS42MDAxWiIgZmlsbD0iI2ZmZiIvPgo8cGF0aCBkPSJNNCAxMkwxMiA0TDQgMTJaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00IDEyTDEyIDQiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLXdpZHRoPSIxLjUiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgo8L3N2Zz4K&logoColor=ffffff)](https://zread.ai/Yttehs-HDX/Nix-flake-config)

|English|[简体中文](./docs/README.cn.md)|

A modular, reproducible Nix Flake for managing multi-host and multi-user configurations, with Home Manager integration.

## Documentation
- Index: [`docs/index.md`](docs/index.md)

## Getting Started
Apply the system configuration for a host:

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

> [!WARNING]
> This is my personal config and may still contain **BUGS**.
>
> It is not recommended to use it directly. Use it as a reference and adjust as needed.

## Key Features
- **Profile-driven** – Define users and hosts via profiles to isolate environments and settings.
- **Environment isolation** – Host and user configurations are independent, reducing conflicts.
- **Modular composition** – Combine system / home / desktop modules as needed.
- **Reusable logic** – Common logic lives under `_lib/` to reduce duplication.
- **Declarative configuration** – All state is defined in Nix, making it reproducible and versioned.

## Repository Layout
- [`flake.nix`](flake.nix) – top-level flake aggregating Nixpkgs, Home Manager, NUR, NixVim, and other inputs.
- [`hosts/`](hosts/) – host configuration and hardware info (e.g., [`Shetty-Laptop/`](hosts/Shetty-Laptop/)).
- [`system/`](system/) – NixOS system-level modules: global config, system software, and home-aux.
- [`home/`](home/) – Home Manager user-level modules: global config and packages.
- [`users/`](users/) – user profile definitions (e.g., [`shetty/`](users/shetty/)).
- [`desktop/`](desktop/) – desktop-layer configuration, including:
  - [`aux/`](desktop/aux/) – auxiliary utilities (waybar, rofi, swaync, etc.)
  - [`dm/`](desktop/dm/) – display manager (sddm)
  - [`sessions/`](desktop/sessions/) – window manager sessions (hyprland)
  - [`styles/`](desktop/styles/) – fonts and themes

## Flake Inputs
| Input | Description |
|-------|-------------|
| [nixpkgs](https://github.com/nixos/nixpkgs) | NixOS 25.11 packages |
| [home-manager](https://github.com/nix-community/home-manager) | User environment management |
| [nur](https://github.com/nix-community/NUR) | Nix User Repository |
| [nixvim](https://github.com/nix-community/nixvim) | Neovim configuration in Nix |
| [hexecute](https://github.com/ThatOtherAndrew/Hexecute) | Custom utility |

## Credit
Some configurations are based on
[Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS).

## License
This project is licensed under the [MIT License](LICENSE).
