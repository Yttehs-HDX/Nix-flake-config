# AGENTS.md

This repository is a personal Nix flake configuration project. It is not a configuration framework.

## Guiding principles

1. **NixOS module system is the framework** — do not build another layer on top of `imports`.
2. **File names express responsibility boundaries** — `git.nix`, `zsh.nix`, `niri.nix`.
3. **Use `imports` for composition** — not custom pipelines, registries, or auto-discovery.
4. **Use official NixOS / Home Manager options** — not custom option schemas.

## Module types

- **leaf module** — writes actual config using official options. Example: `modules/home/zsh.nix`
- **bundle module** — only `imports` leaf modules. Example: `modules/home/desktop/niri/default.nix`
- **entrypoint** — selects the final composition. Example: `home/shetty/laptop.nix`

## Directory structure

```
flake.nix              — declares inputs, nixosConfigurations, homeConfigurations
hosts/nixos/<name>/    — per-machine NixOS configs (hardware, users, system services)
home/<user>/           — per-user Home Manager entrypoints (laptop, server, etc.)
modules/nixos/         — reusable NixOS leaf and bundle modules
modules/home/          — reusable Home Manager leaf and bundle modules
overlays/              — nixpkgs overlays
```

## What to do

- Keep config in official NixOS / Home Manager options.
- Use `imports` to express module composition.
- Split complex config into leaf modules.
- Keep system (NixOS) and user (Home Manager) concerns separate.
- Keep theme and desktop concerns separate.
- Retain standalone Home Manager outputs for `home-manager switch`.

## What to avoid

- Custom option schemas (e.g., `my.desktop.niri.enable`).
- Auto-discovery of directories to generate config.
- Putting user groups in Home Manager (groups belong to NixOS).
- Desktop bundles that hardcode a theme.
- Theme bundles that control window manager behavior.
- Hiding flake entrypoints behind abstraction layers.

## When to create a new module

- Used by 1-2 places: inline or direct import.
- Used by 3+ places: extract to `modules/`.
- Needs root: goes in `modules/nixos/` or `hosts/`.
- User-only: goes in `modules/home/` or `home/`.

## Validation

```bash
nix flake check
nix build .#homeConfigurations."shetty@yuki".activationPackage
nix build .#nixosConfigurations.yuki.config.system.build.toplevel
```
