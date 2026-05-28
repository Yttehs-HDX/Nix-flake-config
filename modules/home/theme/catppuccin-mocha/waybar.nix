let palette = import ./palette.nix;
in {
  programs.waybar.style = ''
    @define-color rosewater ${palette.rosewater};
    @define-color flamingo ${palette.flamingo};
    @define-color pink ${palette.pink};
    @define-color mauve ${palette.mauve};
    @define-color red ${palette.red};
    @define-color maroon ${palette.maroon};
    @define-color peach ${palette.peach};
    @define-color yellow ${palette.yellow};
    @define-color green ${palette.green};
    @define-color teal ${palette.teal};
    @define-color sky ${palette.sky};
    @define-color sapphire ${palette.sapphire};
    @define-color blue ${palette.blue};
    @define-color lavender ${palette.lavender};
    @define-color text ${palette.text};
    @define-color subtext1 ${palette.subtext1};
    @define-color subtext0 ${palette.subtext0};
    @define-color overlay2 ${palette.overlay2};
    @define-color overlay1 ${palette.overlay1};
    @define-color overlay0 ${palette.overlay0};
    @define-color surface2 ${palette.surface2};
    @define-color surface1 ${palette.surface1};
    @define-color surface0 ${palette.surface0};
    @define-color base ${palette.base};
    @define-color mantle ${palette.mantle};
    @define-color crust ${palette.crust};

    * {
      font-family: "SF Pro", "Noto Sans CJK JP", "Noto Sans CJK TC", "Noto Sans CJK SC";
      font-size: 17px;
      min-height: 0;
    }

    #waybar {
      background: transparent;
      color: @text;
    }

    #hyprland,
    #cava,
    #misc,
    #monitor,
    #connection,
    #quick,
    #power {
      border: 2px solid @lavender;
      background-color: rgba(49, 50, 68, 0.8);
      padding: 0.25rem 0.55rem;
      margin: 0 0.1rem;
    }

    #hyprland,
    #connection,
    #power {
      border-radius: 0.9rem;
    }

    #cava,
    #misc,
    #monitor,
    #quick {
      border-radius: 5rem;
    }

    #hyprland   { border-color: @sky; }
    #cava       { border-color: @pink;   color: @maroon; }
    #misc       { border-color: @blue; }
    #monitor    { border-color: @yellow; }
    #connection { border-color: @lavender; }
    #quick      { border-color: @blue; }
    #power      { border-color: @green; }

    #workspaces,
    #clock,
    #custom-lyric,
    #cpu,
    #memory,
    #backlight,
    #pulseaudio,
    #network,
    #bluetooth,
    #custom-hexecute,
    #tray,
    #idle_inhibitor,
    #battery {
      padding: 0 0.35rem;
      margin: 0;
    }

    #clock           { color: @blue; }
    #custom-lyric    { color: @text; }
    #cpu             { color: @peach; }
    #memory          { color: @teal; }
    #backlight       { color: @yellow; }
    #pulseaudio      { color: @maroon; }
    #network         { color: @lavender; }
    #bluetooth       { color: @mauve; }
    #custom-hexecute { color: @blue; }
    #idle_inhibitor  { color: @teal; }
    #battery         { color: @green; }

    #workspaces {
      padding: 0 0.15rem;
    }
    #workspaces button {
      background: @surface1;
      color: @lavender;
      border-radius: 1rem;
      padding: 0 0.3rem;
      margin: 0 0.15rem;
      min-width: 0;
    }
    #workspaces button.active,
    #workspaces button:hover {
      background: @sky;
      color: @surface1;
    }
    #window {
      padding: 0 0rem;
      margin: 0;
    }

    #battery.charging               { color: @green; }
    #battery.warning:not(.charging) { color: @red; }
  '';
}
