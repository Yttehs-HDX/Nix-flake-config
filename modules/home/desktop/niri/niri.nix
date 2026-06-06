{
  pkgs,
  ...
}:

let
  configKDL = ''
    // ── Input ────────────────────────────────────────────────────────────────
    input {
        keyboard {
            xkb {
                layout "us"
            }
        }
        touchpad {
            tap
            dwt
        }
    }

    prefer-no-csd
    hotkey-overlay

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

    // ── Layout ───────────────────────────────────────────────────────────────
    layout {
        gaps 2
        center-focused-column "never"
        default-column-width { proportion 0.5; }
        border {
            width 1
            active-color "#cba6f7"
            inactive-color "#45475a"
        }
        struts {
            left 0
            right 0
            top 0
            bottom 1
        }
    }

    // ── Animations ───────────────────────────────────────────────────────────
    animations {
        slowdown 1
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

        // ── Column & window management ───────────────────────────────────────
        Mod+Q { close-window; }
        Mod+F { fullscreen-window; }
        Mod+Shift+F { maximize-column; }
        Mod+M { maximize-column; }
        Mod+C { center-column; }
        Mod+R { switch-preset-column-width; }
        Mod+V { toggle-window-floating; }
        Mod+Shift+E { quit; }
        Mod+F1 { show-hotkey-overlay; }

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

        // ── Scroll ───────────────────────────────────────────────────────────
        // Built-in: scrolling on empty area moves the ribbon left/right.
        // Built-in: Mod+scroll switches workspaces.

        // ── Media keys ───────────────────────────────────────────────────────
        XF86AudioNext       { spawn "playerctl" "next"; }
        XF86AudioPause      { spawn "playerctl" "play-pause"; }
        XF86AudioPlay       { spawn "playerctl" "play-pause"; }
        XF86AudioPrev       { spawn "playerctl" "previous"; }
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute        { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        XF86MonBrightnessUp   { spawn "brightnessctl" "s" "5%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "s" "5%-"; }
        xf86KbdBrightnessUp   { spawn "brightnessctl" "-d" "*::kbd_backlight" "set" "33%+"; }
        xf86KbdBrightnessDown { spawn "brightnessctl" "-d" "*::kbd_backlight" "set" "33%-"; }

        // ── Utilities ────────────────────────────────────────────────────────
        Mod+W { spawn "sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"; }
        Mod+E { spawn "rofimoji" "--action" "copy" "--prompt" "emoji" "--use-icons"; }
        Print { spawn "screenshot"; }
        Mod+Shift+S { spawn "screenshot"; }
        Mod+Shift+T { spawn "ocr"; }
        Mod+Alt+L { spawn "swaylock"; }
        Mod+Alt+Delete { spawn "hyprpicker" "--autocopy" "--format=hex"; }
    }
  '';
in
{
  home.packages = with pkgs; [
    niri
    xwayland-satellite
    hyprpicker
  ];

  xdg.configFile."niri/config.kdl".text = configKDL;
}
