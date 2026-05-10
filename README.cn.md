# Nix Flake Config

[English](README.md) | [简体中文](README.cn.md)

[![CI](https://img.shields.io/github/actions/workflow/status/Yttehs-HDX/nix-flake-config/ci.yml?branch=main&style=for-the-badge&label=CI)](https://github.com/Yttehs-HDX/nix-flake-config/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-0b7285?style=for-the-badge)](LICENSE)
[![Nix](https://img.shields.io/badge/Nix-Config-5277C3?logo=nixos&logoColor=white&style=for-the-badge)](https://nixos.org/)
[![Flake](https://img.shields.io/badge/Nix-Flake-2F855A?style=for-the-badge)](https://nixos.wiki/wiki/Flakes)
[![Platforms](https://img.shields.io/badge/Platforms-NixOS%20%7C%20nix--darwin%20%7C%20Home%20Manager-374151?style=for-the-badge)](#)

一个分层的 Nix flake 配置仓库，围绕统一的声明式模型构建。

该仓库会将同一份用户、主机与软件意图投影到多个主机与操作系统后端（包括 NixOS、nix-darwin 和 Home Manager）。通过将稳定语义与后端适配解耦，它可以减少重复配置、保持跨平台一致性，并将平台差异限制在投影层中。

## 一等元素
仓库围绕四个一等元素构建：
- **users**：长期稳定的用户语义与偏好
- **hosts**：主机身份、能力与系统边界
- **relations**：用户与主机之间的绑定；也是实例化的唯一入口
- **packages**：跨 packages / programs / services 的统一软件意图抽象

## 设计
这不是一个传统的、按主机文件组织的 Nix 配置仓库。  
相反，它将声明层与派生结果分离，并通过显式边界保证系统长期可扩展、可组合、可维护。

## 文档
架构与设计细节请从这里开始：
- [docs/README.md](docs/README.md)

## 第三方 Nix 模块与库

| 名称 | 类型 | 使用位置 | 用途 |
| --- | --- | --- | --- |
| [nixpkgs](https://github.com/NixOS/nixpkgs) | Flake 输入 / 包集合 | `flake.nix`, `modules/assembly/nixos.nix`, `modules/assembly/darwin.nix` | 提供包集合、`lib` 以及 NixOS 系统构建器。 |
| [nix-darwin](https://github.com/nix-darwin/nix-darwin) | Flake 输入 / Darwin 系统库 | `flake.nix`, `modules/assembly/darwin.nix` | 提供 macOS（`nix-darwin`）系统构建器。 |
| [home-manager](https://github.com/nix-community/home-manager) | Flake 输入 / Nix 模块库 | `flake.nix`, `modules/assembly/nixos.nix`, `modules/assembly/darwin.nix`, `modules/assembly/home-manager.nix` | 提供 Home Manager 模块以及独立 Home Manager 配置构建器。 |
| [nixvim](https://github.com/nix-community/nixvim) | Flake 输入 / Home Manager 模块 | `flake.nix`, `modules/packages/nixvim/home.nix` | 引入 `nixvim` 的 Home Manager 模块，以声明式方式配置 Neovim。 |
| [NUR](https://github.com/nix-community/NUR) | Flake 输入 / 包来源 | `flake.nix`, `modules/projection/common/package-sources.nix`, `modules/packages/mikusays/home.nix` | 提供第三方包来源（例如 `mikusays`）。 |
| [Hexecute](https://github.com/ThatOtherAndrew/Hexecute) | Flake 输入 / 包来源 | `flake.nix`, `modules/projection/common/package-sources.nix`, `modules/packages/hexecute/home.nix` | 提供第三方包来源（`hexecute`）。 |
| [nix-openclaw](https://github.com/openclaw/nix-openclaw) | Flake 输入 / Home Manager 模块 + 包来源 | `flake.nix`, `modules/projection/common/package-sources.nix`, `modules/packages/openclaw/home.nix` | 提供 `openclaw` 的 Home Manager 模块（`programs.openclaw`）及包来源，安装 OpenClaw 并管理 `openclaw-gateway` systemd 用户服务。 |

说明：
- 这里的“Nix 模块”指通过 `imports = [ ... ]` 导入的条目。
- 在当前仓库中，直接导入的第三方模块主要来自 `home-manager`、`nixvim` 与 `nix-openclaw`；`NUR` 和 `Hexecute` 仅作为包来源使用。

## 致谢
部分配置基于 [Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS)。

## 许可证
本项目基于 [MIT](LICENSE) 许可证开源。
