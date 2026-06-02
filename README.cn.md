# Nix Flake Config

[English](README.md) | [简体中文](README.cn.md)

[![CI](https://img.shields.io/github/actions/workflow/status/Yttehs-HDX/nix-flake-config/ci.yml?branch=main&style=for-the-badge&label=CI)](https://github.com/Yttehs-HDX/nix-flake-config/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-0b7285?style=for-the-badge)](LICENSE)
[![Nix](https://img.shields.io/badge/Nix-Config-5277C3?logo=nixos&logoColor=white&style=for-the-badge)](https://nixos.org/)
[![Flake](https://img.shields.io/badge/Nix-Flake-2F855A?style=for-the-badge)](https://nixos.wiki/wiki/Flakes)

个人 Nix flake 配置，用于声明式管理 NixOS 与 Home Manager。

## 目录结构

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

## 文档

- [docs/](docs/) — 使用教程

## 用法

```bash
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
```

## 第三方 Flake 输入

| 输入 | 用途 |
| --- | --- |
| [nixpkgs](https://github.com/NixOS/nixpkgs) | 稳定包集合 (nixos-26.05) |
| [nixpkgs-unstable](https://github.com/NixOS/nixpkgs) | 不稳定分支包集合 |
| [home-manager](https://github.com/nix-community/home-manager) | Home Manager 模块与独立构建器 |
| [nix-darwin](https://github.com/nix-darwin/nix-darwin) | macOS 系统构建器（暂未使用） |
| [nixvim](https://github.com/nix-community/nixvim) | 声明式 Neovim 配置 |
| [NUR](https://github.com/nix-community/NUR) | 社区包仓库 |
| [Hexecute](https://github.com/ThatOtherAndrew/Hexecute) | 第三方包 |
## 致谢

部分配置基于 [Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS)。

## 许可证

本项目基于 [MIT](LICENSE) 许可证开源。
