---
name: format-nix
description: 'Two-phase formatting for Nix files. Use when: user says "format", "格式化", "format nix files", or wants to format .nix files in this repo. Phase 1 applies custom formatting rules nixfmt misses (single-line function args, single-line lists/attrsets, blank lines). Phase 2 runs nixfmt as the final pass. The nixfmt output is the definitive result — do not re-edit after phase 2.'
argument-hint: 'Optional: file path or directory, e.g. "modules/home" or "flake.nix". Defaults to all changed .nix files.'
---

# Format Nix

Two-phase Nix formatting for this repo.

## Phase 1 — Custom Formatting

These are rules `nixfmt` (1.2.0) does not enforce. Apply them BEFORE running nixfmt.

### 1. Function arguments on ONE line

```nix
# BEFORE (nixfmt kept this multi-line)
{
  pkgs,
  lib,
  ...
}:

# AFTER → { pkgs, lib, ... }:
```

Always collapse `{ ... }:` to a single line with a space after `{` and before `}`.

### 2. Simple lists on ONE line

```nix
# BEFORE
modules-left = [
  "group/niri"
  "cava"
];

# AFTER → modules-left = [ "group/niri" "cava" ];
```

Spaces inside brackets: `[ a b c ]`. Applies to all simple values — not to list items that are themselves multi-line attrsets.

### 3. Simple attrsets stay MULTI-LINE

Keep attrsets on multiple lines even if they're short — do NOT collapse them to a single line. nixfmt also preserves this multi-line style.

```nix
# GOOD — multi-line
environment.sessionVariables = {
  XCURSOR_THEME = "...";
  XCURSOR_SIZE = "24";
};

# BAD — do NOT collapse
environment.sessionVariables = { XCURSOR_THEME = "..."; XCURSOR_SIZE = "24"; };
```

### 4. Blank line between function args (inputs) and body (output)

**Always** insert exactly one blank line between the function argument/inputs block and the body/output block. This visually separates the two halves of the function.

```nix
# BEFORE
{ pkgs, ... }:
{

# AFTER
{ pkgs, ... }:

{
```

When a `let ... in` block sits between args and body — a blank line between args and `let`, but **no** blank line between `in` and body:

```nix
{ pkgs, ... }:

let
  foo = ...;
in
{
  ...
}
```

### 5. Remove stray blank lines inside lists

```nix
# BEFORE
imports = [
  ./a.nix

  ./b.nix
];

# AFTER
imports = [
  ./a.nix
  ./b.nix
];
```

## Phase 2 — Run nixfmt

After Phase 1 edits are applied, run `nixfmt` on all changed `.nix` files:

```bash
git diff main --name-only | grep '\.nix$' | while read f; do [ -f "$f" ] && echo "$f"; done | xargs nixfmt
```

## Critical Rule

**nixfmt output is FINAL.** After Phase 2, do NOT re-edit files. nixfmt will expand some single-line lists back to multi-line — that is intentional and correct. The two-phase result is the canonical format for this repo.
