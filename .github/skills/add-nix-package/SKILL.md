---
name: add-nix-package
description: 'Add a new software package to nix-flake-config. Use when: user says "add package X", "add X", "install X", "enable X", "new package X", or wants to integrate a new program/service into the flake. Handles package definition, backend modules, governance metadata, test registration, and optional user/host enablement.'
argument-hint: 'Package name, e.g. "ripgrep" or "neovim"'
---

# Add Package

Add a new package to the nix-flake-config project following the layered architecture.

## When to Use

- User asks to add, install, or enable a new software package
- User wants to integrate a new program or service into the flake

## Reference Links

Use these to look up package availability, options, and NUR packages:

- NixOS packages: https://search.nixos.org/packages
- Home Manager options: https://home-manager-options.extranix.com/
- NixOS options: https://search.nixos.org/options
- NUR packages: https://nur.nix-community.org/
- nix-darwin options: https://nix-darwin.github.io/nix-darwin/manual/
- MyNixOS search: https://mynixos.com/

## Optional: MCP NixOS Tools (Advanced)

**⚠️ Requires separate installation and MCP client configuration.**

If you have [mcp-nixos](https://github.com/utensils/mcp-nixos) configured in your AI client, you can use programmatic queries:

### Installation (choose one):

```bash
# Option 1: uvx (recommended)
uvx mcp-nixos

# Option 2: Nix
nix run github:utensils/mcp-nixos

# Option 3: pip
pip install mcp-nixos
```

### Configuration

Add to your MCP client config (e.g., Claude Desktop, Cursor):

```json
{
  "mcpServers": {
    "nixos": {
      "command": "uvx",
      "args": ["mcp-nixos"]
    }
  }
}
```

### Available Tools (when configured):

**`nix(action, query, source, type, channel, limit)`**

```python
# Search packages
nix(action="search", query="ripgrep", source="nixos")

# Get detailed info
nix(action="info", query="neovim", source="nixos")

# Check Home Manager options
nix(action="search", query="git", source="home-manager", type="programs")

# Check NixOS options
nix(action="search", query="docker", source="nixos", type="options")

# Browse options by prefix
nix(action="options", source="home-manager", query="programs.git")
```

**`nix_versions(package, version, limit)`**

```python
# Check versions and platform support
nix_versions(package="python", limit=5)

# Find specific version
nix_versions(package="nodejs", version="20.0.0")
```

**Sources:** nixos (130K+ pkgs), home-manager (5K+ opts), darwin (1K+ opts), nixhub, noogle (2K+ fns)

## Procedure

### Step 1 — Research the Package

Use the reference links above to determine:

1. **Search for the package:**
   - Go to https://search.nixos.org/packages or https://mynixos.com/
   - Search for the package name (e.g., "ollama", "ripgrep")
   - Verify it exists in nixpkgs

2. **Check for dedicated options:**
   - **Home Manager:** https://home-manager-options.extranix.com/ or https://mynixos.com/home-manager/options
     - Look for `programs.<name>.*` or `services.<name>.*`
   - **NixOS:** https://search.nixos.org/options or https://mynixos.com/nixos/options
     - Look for `services.<name>.*`, `hardware.<name>.*`, etc.
   - **nix-darwin:** https://nix-darwin.github.io/nix-darwin/manual/ or https://mynixos.com/nix-darwin/options
     - Look for system-level darwin options

3. **Extract information:**
   - Whether the package exists in nixpkgs (`pkgs.<name>`)
   - Whether home-manager has dedicated options (`programs.<name>`, `services.<name>`)
   - Whether nixos has dedicated options (`services.<name>`, `hardware.<name>`, etc.)
   - Whether nix-darwin has dedicated options
   - Platform support (check package metadata for supported systems)

4. **Determine the owner** — who should declare this package:
   - `user`: user-level tools, programs, GUI apps, shells, editors (most packages)
   - `host`: system services, hardware drivers, virtualization, networking, firewalls

5. **Determine the platform scope:**
   - Cross-platform (Linux + macOS): works everywhere
   - Linux-only desktop: requires Linux + desktop capability (Wayland/X11 tools)
   - Linux-only system: NixOS system-level only (drivers, system services)
   - Darwin-hint: Linux auto-install, macOS manual-install hint

### Step 2 — Choose the Preset

Select from `modules/package-governance/presets.nix`:

| Preset | Owner | Platforms | Desktop? | Example |
|--------|-------|-----------|----------|---------|
| `crossPlatformUserPackage` | user | all | no | bat, git, jq, ripgrep |
| `linuxDesktopUser` | user | linux | yes | hyprland, rofi, waybar |
| `linuxDesktopHost` | host | linux | yes | blueman |
| `darwinHintManual` | user | linux (hint on darwin) | no | google-chrome, krita |
| `linuxSystemHost` | host | nixos only | no | bluetooth, nvidia, tlp |
| `crossPlatformSystemHost` | host | all | no | docker, networking |
| `linuxDesktopSystemHost` | host | nixos only | yes | sddm |

### Step 3 — Choose the Kind

The `kind` string classifies the package semantically. Pick the closest:

| Kind | Use for |
|------|---------|
| `"package"` | Simple CLI tools, utilities (bat, jq, ripgrep, htop) |
| `"gui"` | GUI applications (google-chrome, vlc, krita, feishu) |
| `"service"` | Background services, daemons (bluetooth, syncthing, hypridle) |
| `"environment"` | Shell/environment setup (zsh, xdg) |
| `"theme-consumer"` | Fonts, theme packages (nerd-fonts-jetbrains-mono) |
| `"desktop-component"` | Desktop integration pieces (wl-clipboard, libnotify, sddm) |
| `"desktop-input-method"` | Input methods (fcitx5) |
| `"desktop-session"` | Window managers, compositors (hyprland) |
| `"integration-heavy"` | Complex multi-backend packages (neovim, clash-verge-rev) |
| `"custom"` | Packages from custom sources (hexecute, mikusays) |

### Step 4 — Create the Package Directory

Create `modules/packages/<packageId>/default.nix`.

The `packageId` is the directory name. Use lowercase with hyphens (e.g., `google-chrome`, `nix-ld`).

### Step 5 — Write `default.nix`

Template — adapt the backends block based on research:

```nix
# <packageId> package definition
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "<packageId>";

  metadata = presets.<preset> "<kind>";

  backends = {
    home-manager = {
      home = <home-path-or-null>;
      system = null;
    };
    nixos = {
      home = <home-path-or-null>;
      system = <system-path-or-null>;
    };
    nix-darwin = {
      home = <home-path-or-null>;
      system = <system-path-or-null>;
    };
  };
}
```

**Backend path rules:**
- If the package uses home-manager options → `home = ./home.nix;`
- If the package uses nixos system-level options → `system = ./nixos.nix;`
- If the package uses nix-darwin system-level options → `system = ./darwin.nix;`
- If the backend/scope is not applicable → `null`
- For cross-platform user packages where all backends share the same home config, point all three `home` fields to `./home.nix`

### Step 6 — Write Backend Module Files

Each module file follows a **two-layer curried function** pattern:

```
{ input, definition, ... }:    # ← layer 1: package context (from projection)
{ lib, pkgs, config, ... }:    # ← layer 2: NixOS/home-manager module args
{ ... config ... }             # ← module body
```

If a module doesn't need `input` or `definition`, use `{ ... }:` for that layer.

#### Pattern A — Has dedicated options (PREFERRED)

When home-manager or nixos has `programs.<name>` or `services.<name>`:

**home.nix** example (programs):
```nix
{ ... }:
{ ... }: {
  programs.<name>.enable = true;
}
```

**home.nix** example (services):
```nix
{ ... }:
{ ... }: {
  services.<name>.enable = true;
}
```

**nixos.nix** example:
```nix
{ ... }:
{ ... }: {
  services.<name>.enable = true;
}
```

#### Pattern B — No dedicated options, use raw package

When there are no options, add to the package list:

**home.nix**:
```nix
{ ... }:
{ pkgs, ... }: {
  home.packages = [ pkgs.<name> ];
}
```

**nixos.nix** (system-level):
```nix
{ ... }:
{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.<name> ];
}
```

#### Pattern C — With settings and input access

When the module needs `definition.settings` or `input.*`:

**home.nix**:
```nix
{ input, definition, ... }:
{ lib, pkgs, ... }: {
  programs.<name> = {
    enable = true;
    someSetting = definition.settings.someSetting or "default";
  };
}
```

Available `input` fields in module context:
- `input.current.user.preferences.shell` — user's preferred shell
- `input.current.user.preferences.editor` — user's preferred editor
- `input.current.user.preferences.terminal` — user's preferred terminal
- `input.theme` — resolved theme (may be null)
- `input.identity.name` — instance username
- `input.identity.homeDirectory` — home path
- `input.packages.home` — attrset of enabled home-scope packages (use `? packageId` to check)

#### Pattern D — Empty stub (backend exists but no config needed)

```nix
{ ... }: { ... }: { }
```

### Step 7 — Register in Test Lists

Open `tests/package-definitions.nix` and add the packageId to the appropriate list:

| List | When to add |
|------|-------------|
| `migratedCrossPlatformUserPackages` | preset = `crossPlatformUserPackage` |
| `migratedLinuxDesktopUserPackages` | preset = `linuxDesktopUser` |
| `migratedDarwinHintPackages` | preset = `darwinHintManual` |
| `migratedSystemPackages` | preset = `linuxSystemHost`, `crossPlatformSystemHost`, `linuxDesktopSystemHost` |
| `migratedCustomConstraintPackages` | Custom metadata (not using a standard preset directly) |

**Also** add an assertion in `assertDefinitionsExist`:
```nix
assert builtins.hasAttr "<packageId>" packageDefinitions;
```

### Step 8 — Validate

Run:
```bash
nix flake check path:$PWD
```

> **Important**: New untracked files are invisible to git-based flake checks.
> Use `path:$PWD` or stage the files with `git add` before checking.

### Step 9 — Ask About Enablement

After the package is created and validated, ask the user:

> "Do you want to enable `<packageId>` for a specific user or host?"

If yes:
- **User-owned packages**: Add `<packageId> = { };` to the user's `packages` block in `users/<userName>/default.nix`
- **Host-owned packages**: Add `<packageId> = { };` to the host's `packages` block in `hosts/<hostName>/default.nix`
- If the package has useful settings, suggest them: `<packageId>.settings = { ... };`

## Common Patterns Reference

### Simplest user package (CLI tool, cross-platform)
```
preset:   crossPlatformUserPackage "package"
backends: home-manager/nixos/nix-darwin all → home = ./home.nix
home.nix: home.packages = [ pkgs.<name> ];
```

### User package with program options
```
preset:   crossPlatformUserPackage "package"
backends: home-manager/nixos/nix-darwin all → home = ./home.nix
home.nix: programs.<name>.enable = true;
```

### Linux desktop user package
```
preset:   linuxDesktopUser "<kind>"
backends: home-manager/nixos → home = ./home.nix; nix-darwin → home = null
home.nix: programs.<name>.enable = true; (or home.packages)
```

### Linux system service (host-owned)
```
preset:   linuxSystemHost "service"
backends: nixos → system = ./nixos.nix; others → null
nixos.nix: services.<name>.enable = true;
```

### Cross-platform system service (host-owned)
```
preset:   crossPlatformSystemHost "service"
backends: nixos → system = ./nixos.nix; nix-darwin → system = ./darwin.nix; home-manager → null
```

### macOS manual-install hint package
```
preset:   darwinHintManual "gui"
backends: all three → home = ./home.nix
home.nix: home.packages = [ pkgs.<name> ];
```

## Complete Example: Adding a Package

**Scenario:** User wants to add `ollama` (LLM tool).

### Step-by-step Research:

1. **Search on https://search.nixos.org/packages?query=ollama**
   - Result: `pkgs.ollama` exists (LLM inference server)
   - Available on: x86_64-linux, aarch64-linux, x86_64-darwin, aarch64-darwin

2. **Check NixOS options at https://mynixos.com/nixos/options?search=ollama**
   - Found: `services.ollama.enable` - NixOS service for Ollama
   - Options: `acceleration` (cuda/rocm/vulkan), `models`, `environmentVariables`

3. **Check Home Manager at https://mynixos.com/home-manager/options?search=ollama**
   - No dedicated `programs.ollama` or `services.ollama` options

4. **Decision matrix:**
   - Owner: **host** (system service that runs as daemon)
   - Platform: **cross-platform** (Linux + macOS)
   - NixOS has service options: yes (`services.ollama`)
   - Home Manager options: no (use raw package)
   - Kind: **"service"**
   - → Preset: **`crossPlatformSystemHost "service"`**

### Implementation:

**Create:** `modules/packages/ollama/default.nix`
```nix
{ lib }:
let presets = import ../../package-governance/presets.nix;
in {
  packageId = "ollama";
  metadata = presets.crossPlatformSystemHost "service";
  backends = {
    home-manager = {
      home = ./home.nix;
      system = null;
    };
    nixos = {
      home = null;
      system = ./nixos.nix;
    };
    nix-darwin = {
      home = ./home.nix;
      system = null;
    };
  };
}
```

**Create:** `modules/packages/ollama/nixos.nix`
```nix
{ ... }:
{ ... }: {
  services.ollama.enable = true;
}
```

**Create:** `modules/packages/ollama/home.nix`
```nix
# Fallback for non-NixOS systems (macOS/standalone home-manager)
{ ... }:
{ pkgs, ... }: {
  home.packages = [ pkgs.ollama ];
}
```

**Register in:** `tests/package-definitions.nix`
```nix
migratedSystemPackages = [
  # ... existing packages
  "ollama"
];

# In assertDefinitionsExist:
assert builtins.hasAttr "ollama" packageDefinitions;
```

**Validate:**
```bash
nix flake check path:$PWD
```

**Notes:**
- NixOS uses `services.ollama` (native service)
- macOS/home-manager uses raw package (no service integration)
- Settings can be passed via `definition.settings` if needed (e.g., acceleration mode)
