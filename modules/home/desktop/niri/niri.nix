{ pkgs, ... }:

let
  palette = import ../../theme/catppuccin-mocha/palette.nix;

  configKDL = ''
    // ── Input ────────────────────────────────────────────────────────────────
    input {
        keyboard {
            xkb {
                layout "us"
            }
            numlock
        }
        touchpad {
            tap
            dwt
            natural-scroll
        }
        workspace-auto-back-and-forth
    }

    prefer-no-csd

    // ── Screenshots ───────────────────────────────────────────────────────────
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // ── Cursor ────────────────────────────────────────────────────────────────
    cursor {
        hide-when-typing
    }

    // ── Hotkey Overlay ────────────────────────────────────────────────────────
    hotkey-overlay {
        skip-at-startup
    }

    // ── Environment ──────────────────────────────────────────────────────────
    environment {
        XDG_CURRENT_DESKTOP "niri"
        XDG_SESSION_DESKTOP "niri"
        XDG_SESSION_TYPE "wayland"
        GDK_BACKEND "wayland,x11,*"
        GDK_SCALE "1"
        GDK_DPI_SCALE "1"
        NIXOS_OZONE_WL "1"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        MOZ_ENABLE_WAYLAND "1"
        OZONE_PLATFORM "wayland"
        EGL_PLATFORM "wayland"
        CLUTTER_BACKEND "wayland"
        SDL_VIDEODRIVER "wayland"
        QT_QPA_PLATFORM "wayland;xcb"
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        QT_AUTO_SCREEN_SCALE_FACTOR "1"
    }

    // ── Xwayland Satellite ────────────────────────────────────────────────────
    xwayland-satellite {
        path "xwayland-satellite"
    }

    // ── Blur ──────────────────────────────────────────────────────────────────
    blur {
        passes 3
        offset 3.0
        noise 0.02
        saturation 1.5
    }

    // ── Layout ───────────────────────────────────────────────────────────────
    layout {
        gaps 3
        center-focused-column "never"
        default-column-width {
            proportion 1.0;
        }
        focus-ring {
            width 1
            active-color "${palette.lavender}"
            inactive-color "${palette.pink}"
        }
        border {
            width 1
            active-color "${palette.lavender}"
            inactive-color "${palette.pink}"
            urgent-color "${palette.red}"
        }
        // Drop shadows for windows.
        shadow {
            on
            softness 30
            spread 5
            offset x=0 y=5
            color "#00000070"
        }
        // Tab indicator for tabbed columns (Mod+Shift+W to toggle).
        tab-indicator {
            hide-when-single-tab
            width 3
            gap 2
            active-color "${palette.lavender}"
            inactive-color "${palette.pink}"
            urgent-color "${palette.red}"
        }
        // Insert hint shown during interactive window moves.
        insert-hint {
            color "${palette.lavender}80"
        }
        struts {
            left 3
            right 3
            top 5
            bottom 5
        }
        // Background color for workspaces (visible when no background tool is running).
        background-color "${palette.base}"
    }

    // ── Overview ──────────────────────────────────────────────────────────────
    overview {
        zoom 1.0
        backdrop-color "${palette.base}"
        workspace-shadow {
            softness 40
            spread 10
            offset x=0 y=10
            color "#00000050"
        }
    }

    // ── Window Rules ──────────────────────────────────────────────────────────
    // Global: rounded corners for all windows.
    window-rule {
        match app-id=r#"."#
        geometry-corner-radius 10
        clip-to-geometry true
    }

    // ── Layer Rules ───────────────────────────────────────────────────────────
    // Rofi: layer-shell surface on overlay layer. Theme uses bg-col=#1e1e2ebf (~75% opaque)
    // so there's enough transparency for blur to be visible.
    layer-rule {
        match namespace="rofi"
        geometry-corner-radius 15
        background-effect {
            xray false
            blur true
        }
        popups {
            background-effect {
                xray false
                blur true
            }
        }
    }

    // ── Animations ───────────────────────────────────────────────────────────
    animations {
        slowdown 1

        // Individual animation tuning.
        // Spring defaults for workspace switching and view movement.
        workspace-switch {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
        }
        horizontal-view-movement {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }
        window-movement {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }
        window-resize {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }
        window-open {
            duration-ms 150
            curve "ease-out-expo"
        }
        window-close {
            duration-ms 150
            curve "ease-out-quad"
        }
        overview-open-close {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }
        screenshot-ui-open {
            duration-ms 200
            curve "ease-out-quad"
        }
    }

    // ── Startup ──────────────────────────────────────────────────────────────
    spawn-at-startup "fcitx5" "-d"
    spawn-at-startup "waybar"
    spawn-at-startup "awww"

    // ── Keybindings ──────────────────────────────────────────────────────────
    // Follows niri community conventions — primary nav via arrows + Home/End,
    // with vim keys as secondary.
    binds {
        // ── Launch ───────────────────────────────────────────────────────────
        Mod+Return { spawn "kitty"; }
        Mod+D { spawn "rofi" "-show" "drun"; }
        Mod+Escape { spawn "hexecute"; }

        // ── Window management ─────────────────────────────────────────────────
        Mod+Q repeat=false { close-window; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+M { maximize-window-to-edges; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }
        Mod+O repeat=false { toggle-overview; }
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-column-width-back; }
        Mod+V { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+Shift+W { toggle-column-tabbed-display; }
        Mod+Shift+E { quit; }
        Mod+Shift+Slash { show-hotkey-overlay; }

        // ── Fine width / height adjustments ───────────────────────────────────
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }
        Mod+Ctrl+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }

        // ── Column ops (niri's scrollable-tiling paradigm) ───────────────────
        Mod+Comma  { consume-or-expel-window-left; }
        Mod+Period { consume-or-expel-window-right; }
        Mod+Shift+Comma  { consume-window-into-column; }
        Mod+Shift+Period { expel-window-from-column; }

        // ── Focus: ribbon navigation ─────────────────────────────────────────
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up    { focus-window-up; }
        Mod+Down  { focus-window-down; }
        Mod+Home  { focus-column-first; }
        Mod+End   { focus-column-last; }

        // ── Focus: vim keys (secondary) ──────────────────────────────────────
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+K { focus-window-up; }
        Mod+J { focus-window-down; }

        // ── Focus: cross-workspace alternatives ───────────────────────────────
        // Uncomment these instead of the regular focus binds to allow crossing
        // workspace boundaries when reaching the first/last window in a column.
        // Mod+J { focus-window-or-workspace-down; }
        // Mod+K { focus-window-or-workspace-up; }

        // ── Move: ribbon reordering ──────────────────────────────────────────
        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Home  { move-column-to-first; }
        Mod+Ctrl+End   { move-column-to-last; }

        // ── Move: vim keys (secondary) ───────────────────────────────────────
        Mod+Ctrl+H { move-column-left; }
        Mod+Ctrl+L { move-column-right; }
        Mod+Ctrl+K { move-window-up; }
        Mod+Ctrl+J { move-window-down; }

        // ── Monitor navigation ────────────────────────────────────────────────
        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+L     { focus-monitor-right; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+J     { focus-monitor-down; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }

        // ── Workspaces ───────────────────────────────────────────────────────
        Mod+1 { focus-workspace 1; }
        Mod+Ctrl+1 { move-window-to-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+Ctrl+2 { move-window-to-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+Ctrl+3 { move-window-to-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+Ctrl+4 { move-window-to-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+Ctrl+5 { move-window-to-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+Ctrl+6 { move-window-to-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+Ctrl+7 { move-window-to-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+Ctrl+8 { move-window-to-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+9 { move-window-to-workspace 9; }
        Mod+0 { focus-workspace 10; }
        Mod+Ctrl+0 { move-window-to-workspace 10; }

        // Workspace up/down (alternative to numbered shortcuts).
        Mod+U { focus-workspace-down; }
        Mod+I { focus-workspace-up; }
        Mod+Ctrl+U { move-column-to-workspace-down; }
        Mod+Ctrl+I { move-column-to-workspace-up; }
        Mod+Shift+U { move-workspace-down; }
        Mod+Shift+I { move-workspace-up; }

        // ── Scroll (mouse wheel) ──────────────────────────────────────────────
        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }
        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        // ── Media keys ───────────────────────────────────────────────────────
        XF86AudioNext       { spawn "playerctl" "next"; }
        XF86AudioPause allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioPlay  allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioPrev       { spawn "playerctl" "previous"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "s" "5%+"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "s" "5%-"; }
        xf86KbdBrightnessUp   { spawn "brightnessctl" "-d" "*::kbd_backlight" "set" "33%+"; }
        xf86KbdBrightnessDown { spawn "brightnessctl" "-d" "*::kbd_backlight" "set" "33%-"; }

        // ── Screenshots ───────────────────────────────────────────────────────
        Print { screenshot show-pointer=false; }
        Ctrl+Print { screenshot-screen show-pointer=false; }
        Alt+Print { screenshot-window show-pointer=false; }
        Mod+Shift+S { spawn "screenshot"; }

        // ── Power ────────────────────────────────────────────────────────────
        Mod+Shift+P { power-off-monitors; }

        // ── Keyboard shortcuts inhibit escape hatch ───────────────────────────
        Mod+Shift+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        // ── Utilities ────────────────────────────────────────────────────────
        Mod+W { spawn "sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"; }
        Mod+E { spawn "rofimoji" "--action" "copy" "--prompt" "emoji" "--use-icons"; }
        Mod+Shift+O { spawn "ocr"; }
        Mod+Shift+T { spawn "ocr-trans"; }
        Mod+Alt+L { spawn "swaylock"; }
        Mod+Alt+Delete { spawn "hyprpicker" "--autocopy" "--format=hex"; }
    }
  '';
in
{
  home.packages = with pkgs; [ niri ];

  xdg.configFile."niri/config.kdl".text = configKDL;
}
