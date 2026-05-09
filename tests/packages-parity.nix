{ lib, inputs }:
let
  evaluated = import ./eval-profile.nix {
    inherit lib inputs;
    declarations = {
      users.Alice = {
        meta.displayName = "Alice Example";
        preferences.shell = "zsh";
        capabilities = {
          desktop.enable = true;
          theme.enable = true;
        };
        theme = {
          name = "catppuccin";
          accent = "lavender";
          flavor = "mocha";
          fonts.sans = "SF Pro";
          fonts.monospace.family = "JetBrainsMono Nerd Font";
        };
        packages = {
          android-tools = { };
          bat = { };
          btop = { };
          cava = { };
          clash-verge-rev = { };
          github-copilot-cli = { };
          direnv = { };
          embedded-dev = { };
          eza = { };
          fastfetch = { };
          feishu = { };
          fcitx5 = { };
          figlet = { };
          fzf = { };
          gh = { };
          git = { };
          google-chrome = { };
          hexecute = { };
          hmcl = { };
          htop = { };
          hyprland = { };
          jq = { };
          kdeconnect = { };
          kitty.settings = {
            fontSize = 14.0;
            backgroundOpacity = 0.9;
            backgroundBlur = 1;
            rememberWindowSize = false;
            shellIntegrationMode = "no_cursor";
          };
          mikusays = { };
          nixvim = { };
          neovim = { };
          network-manager = { };
          nix-index = { };
          nmap = { };
          onlyoffice = { };
          playerctl = { };
          qq = { };
          ripgrep = { };
          rofi = { };
          scrcpy = { };
          seahorse = { };
          taplo = { };
          tgpt = { };
          tldr = { };
          tmux = { };
          udisks2 = { };
          vscode = { };
          waybar = { };
          wechat = { };
          wget = { };
          yazi = { };
          zsh = { };
        };
      };

      hosts.Workstation = {
        backend.type = "nixos";
        platform.system = "x86_64-linux";
        capabilities.system.enable = true;
        capabilities.home.enable = true;
        capabilities.desktop.enable = true;
        capabilities.userManagement.enable = true;
        system.stateVersion = "25.11";
        hardware.modules = [{
          time.timeZone = "Asia/Taipei";
          i18n.defaultLocale = "en_US.UTF-8";
        }];
        packages = {
          asusctl = { };
          bluetooth = { };
          blueman = { };
          docker.settings.storageDriver = "btrfs";
          nix-ld = { };
          networking = { };
          nvidia.settings = {
            nvidiaBusId = "PCI:1:0:0";
            intelBusId = "PCI:0:2:0";
          };
          pipewire = { };
          rog-control-center = { };
          sddm = { };
          supergfxctl = { };
          tlp = { };
          virt-manager = { };
          waydroid = { };
          wireshark.settings.package = "qt";
          zram = { };
        };
      };

      relations."Alice@Workstation" = {
        user = "Alice";
        host = "Workstation";
        identity.name = "alice";
        membership.extraGroups = [ "wheel" ];
        activation.theme.enable = true;
        state.home.stateVersion = "25.05";
      };
    };
  };

  wiresharkOnlyEvaluated = import ./eval-profile.nix {
    inherit lib inputs;
    declarations = {
      users.Alice = { };

      hosts.PacketLab = {
        backend.type = "nixos";
        platform.system = "x86_64-linux";
        capabilities.system.enable = true;
        capabilities.home.enable = true;
        capabilities.userManagement.enable = true;
        system.stateVersion = "25.11";
        packages.wireshark.settings.package = "qt";
      };

      relations."Alice@PacketLab" = {
        user = "Alice";
        host = "PacketLab";
        identity.name = "alice";
        state.home.stateVersion = "25.05";
      };
    };
  };

  nixosConfig = evaluated.assembly.nixosConfigurations.Workstation;
  homeConfig = nixosConfig.config.home-manager.users.alice;
  userConfig = nixosConfig.config.users.users.alice;
  projectionInput = evaluated.pipeline.projectionInputs."Alice@Workstation";
  system = nixosConfig.pkgs.stdenv.hostPlatform.system;
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  hexecutePackage = inputs.hexecute.packages.${system}.default;
  mikusaysPackage = inputs.nur.legacyPackages.${system}.repos.zerozawa.mikusays;

  wiresharkOnlyConfig =
    wiresharkOnlyEvaluated.assembly.nixosConfigurations.PacketLab;
in assert homeConfig.programs.bat.enable;
assert projectionInput.packages.home.hexecute.enable;
assert projectionInput.packages.home.blueman.enable;
assert projectionInput.packages.home.mikusays.enable;
assert projectionInput.packages.home.nixvim.enable;
assert projectionInput.packages.home.neovim.enable;
assert projectionInput.packages.home.pipewire.enable;
assert homeConfig.home.sessionVariables.PAGER
  == "${nixosConfig.pkgs.bat}/bin/bat";
assert homeConfig.programs.eza.enable;
assert homeConfig.programs.eza.enableZshIntegration;
assert homeConfig.programs.eza.icons == "always";
assert homeConfig.programs.eza.git;
assert homeConfig.programs.fzf.enable;
assert homeConfig.programs.fzf.enableZshIntegration;
assert homeConfig.programs.gh.enable;
assert homeConfig.programs.gh.gitCredentialHelper.enable;
assert builtins.elem nixosConfig.pkgs.github-copilot-cli
  homeConfig.home.packages;
assert homeConfig.programs.git.enable;
assert homeConfig.programs.direnv.enable;
assert homeConfig.programs.direnv.silent;
assert homeConfig.programs.direnv.nix-direnv.enable;
assert homeConfig.programs.htop.enable;
assert homeConfig.i18n.inputMethod.enable;
assert homeConfig.i18n.inputMethod.type == "fcitx5";
assert builtins.elem nixosConfig.pkgs.catppuccin-fcitx5
  homeConfig.i18n.inputMethod.fcitx5.addons;
assert homeConfig.home.sessionVariables.GLFW_IM_MODULE == "ibus";
assert homeConfig.home.sessionVariables.XMODIFIERS == "@im=fcitx";
assert homeConfig.wayland.windowManager.hyprland.enable;
assert builtins.elem "fcitx5 -d"
  homeConfig.wayland.windowManager.hyprland.settings.exec-once;
assert builtins.elem "$mod, TAB, hyprexpo:expo, toggle"
  homeConfig.wayland.windowManager.hyprland.settings.bind;
assert builtins.elem "$mod, M, exec, hyprctl dispatch exit"
  homeConfig.wayland.windowManager.hyprland.settings.bind;
assert builtins.elem ", XF86AudioNext, exec, playerctl next"
  homeConfig.wayland.windowManager.hyprland.settings.bindl;
assert builtins.elem ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
  homeConfig.wayland.windowManager.hyprland.settings.bindel;
assert builtins.elem
  ", xf86KbdBrightnessUp, exec, brightnessctl -d *::kbd_backlight set 33%+"
  homeConfig.wayland.windowManager.hyprland.settings.bind;
assert homeConfig.wayland.windowManager.hyprland.settings.plugin.hyprexpo.columns
  == 3;
assert homeConfig.wayland.windowManager.hyprland.settings.plugin.dynamic-cursors.mode
  == "tilt";
assert builtins.length homeConfig.wayland.windowManager.hyprland.plugins == 2;
assert builtins.elem "XDG_CURRENT_DESKTOP,Hyprland"
  homeConfig.wayland.windowManager.hyprland.settings.env;
assert builtins.elem "XDG_SESSION_DESKTOP,Hyprland"
  homeConfig.wayland.windowManager.hyprland.settings.env;
assert builtins.elem "XDG_SESSION_TYPE,wayland"
  homeConfig.wayland.windowManager.hyprland.settings.env;
assert builtins.elem "QT_QPA_PLATFORM,wayland;xcb"
  homeConfig.wayland.windowManager.hyprland.settings.env;
assert homeConfig.programs.nix-index.enable;
assert homeConfig.programs.nix-index.enableZshIntegration;
assert homeConfig.programs.ripgrep.enable;
assert homeConfig.programs.rofi.enable;
assert homeConfig.programs.rofi.terminal == "kitty";
assert homeConfig.programs.rofi.font == "SF Pro 12";
assert homeConfig.programs.tmux.enable;
assert homeConfig.programs.waybar.enable;
assert homeConfig.programs.waybar.systemd.enable;
assert homeConfig.programs.waybar.settings.main.position == "top";
assert homeConfig.programs.waybar.settings.main.modules-left
  == [ "group/hyprland" "cava" ];
assert homeConfig.programs.waybar.settings.main.modules-center
  == [ "group/misc" ];
assert homeConfig.programs.waybar.settings.main."hyprland/workspaces".persistent-workspaces."*"
  == [ 1 2 3 4 5 6 ];
assert homeConfig.programs.waybar.settings.main.cava.on-click
  == "playerctl play-pause";
assert homeConfig.programs.waybar.settings.main."custom/hexecute".tooltip-format
  == "魔法使い";
assert homeConfig.programs.waybar.settings.main."custom/hexecute".on-click
  == "hexecute";
assert lib.hasInfix "@define-color accent" homeConfig.programs.waybar.style;
assert lib.hasInfix "#cava" homeConfig.programs.waybar.style;
assert lib.hasInfix "#custom-hexecute" homeConfig.programs.waybar.style;
assert homeConfig.programs.yazi.enable;
assert homeConfig.programs.yazi.enableZshIntegration;
assert homeConfig.programs.zsh.enable;
assert homeConfig.programs.zsh.enableCompletion;
assert homeConfig.programs.zsh.history.size == 100000;
assert homeConfig.programs.zsh.historySubstringSearch.enable;
assert homeConfig.programs.zsh.autosuggestion.enable;
assert homeConfig.programs.zsh.syntaxHighlighting.enable;
assert homeConfig.programs.zsh.shellAliases.ai == "tgpt -i";
assert builtins.elem "tmux" homeConfig.programs.zsh.oh-my-zsh.plugins;
assert homeConfig.programs.zsh.zplug.enable;
assert lib.hasInfix "source ~/.p10k.zsh" homeConfig.programs.zsh.initContent;
assert builtins.elem nixosConfig.pkgs.taplo homeConfig.home.packages;
assert lib.hasInfix "taplo completions zsh" homeConfig.programs.zsh.initContent;
assert homeConfig.programs.kitty.enable;
assert homeConfig.programs.kitty.themeFile == "Catppuccin-Mocha";
assert homeConfig.programs.kitty.font.name == "JetBrainsMono Nerd Font";
assert homeConfig.programs.kitty.font.size == 14.0;
assert homeConfig.programs.kitty.settings.background_opacity == 0.9;
assert homeConfig.programs.kitty.shellIntegration.enableZshIntegration;
assert homeConfig.programs.onlyoffice.enable;
assert homeConfig.programs.onlyoffice.settings.UITheme == "theme-night";
assert homeConfig.programs.onlyoffice.settings.editorWindowMode == false;
assert homeConfig.programs.onlyoffice.settings.locale == "zh-CN";
assert homeConfig.programs.btop.enable;
assert homeConfig.programs.cava.enable;
assert homeConfig.services.blueman-applet.enable;
assert homeConfig.services.kdeconnect.enable;
assert homeConfig.services.kdeconnect.indicator;
assert homeConfig.services.network-manager-applet.enable;
assert homeConfig.services.udiskie.enable;
assert homeConfig.programs.nixvim.enable;
assert homeConfig.programs.nixvim.defaultEditor;
assert homeConfig.programs.nixvim.opts.number;
assert homeConfig.programs.nixvim.opts.relativenumber;
assert homeConfig.programs.nixvim.opts.shiftwidth == 2;
assert homeConfig.programs.nixvim.plugins.lualine.enable;
assert homeConfig.programs.nixvim.plugins.treesitter.enable;
assert homeConfig.programs.nixvim.plugins.nvim-tree.openOnSetup;
assert homeConfig.programs.nixvim.plugins.cmp.enable;
assert builtins.any (source: source.name == "copilot")
  homeConfig.programs.nixvim.plugins.cmp.settings.sources;
assert homeConfig.programs.nixvim.plugins.cmp.settings.mapping."<Tab>".__raw
  == "cmp.mapping.select_next_item()";
assert homeConfig.programs.nixvim.plugins.cmp-conventionalcommits.enable;
assert homeConfig.programs.nixvim.plugins.cmp-git.enable;
assert homeConfig.programs.nixvim.plugins.cmp-zsh.enable;
assert homeConfig.programs.nixvim.plugins.copilot-lua.enable;
assert homeConfig.programs.nixvim.plugins.copilot-lua.settings.filetypes.markdown
  == false;
assert homeConfig.programs.nixvim.plugins.copilot-cmp.enable;
assert homeConfig.programs.nixvim.plugins.copilot-chat.enable;
assert homeConfig.programs.nixvim.plugins.render-markdown.enable;
assert homeConfig.programs.nixvim.plugins.markdown-preview.enable;
assert homeConfig.programs.nixvim.plugins.trouble.enable;
assert homeConfig.programs.nixvim.plugins.nvim-lightbulb.enable;
assert homeConfig.programs.nixvim.plugins.lsp.servers.sqls.enable;
assert homeConfig.programs.nixvim.plugins.lsp.servers.texlab.enable;
assert homeConfig.programs.nixvim.colorschemes.catppuccin.enable;
assert !homeConfig.programs.neovim.enable;
assert homeConfig.programs.vscode.enable;
assert homeConfig.programs.vscode.package == unstablePkgs.vscode;
assert homeConfig.xdg.configFile."btop/themes/catppuccin-mocha.theme".text
  != "";
assert builtins.elem nixosConfig.pkgs.android-tools homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.google-chrome homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.hmcl homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.fastfetch homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.feishu homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.figlet homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.jq homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.nmap homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.qq homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.tgpt homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.tldr homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.wechat homeConfig.home.packages;
assert builtins.elem nixosConfig.pkgs.wget homeConfig.home.packages;
assert builtins.elem hexecutePackage homeConfig.home.packages;
assert builtins.elem mikusaysPackage homeConfig.home.packages;
assert !builtins.any
  (warning: lib.hasInfix "Package `hexecute` is declared" warning)
  homeConfig.warnings;
assert !builtins.any
  (warning: lib.hasInfix "Package `mikusays` is declared" warning)
  homeConfig.warnings;
assert nixosConfig.config.programs.adb.enable;
assert nixosConfig.config.virtualisation.docker.enable;
assert nixosConfig.config.virtualisation.docker.storageDriver == "btrfs";
assert nixosConfig.config.programs.clash-verge.enable;
assert nixosConfig.config.programs.hyprland.enable;
assert nixosConfig.config.programs.nix-ld.enable;
assert nixosConfig.config.programs.neovim.enable;
assert nixosConfig.config.nixpkgs.config.nvidia.acceptLicense;
assert nixosConfig.config.nixpkgs.config.cudaSupport;
assert nixosConfig.config.hardware.nvidia.prime.offload.enable;
assert nixosConfig.config.services.asusd.enable;
assert nixosConfig.config.services.blueman.enable;
assert nixosConfig.config.services.displayManager.sddm.enable;
assert nixosConfig.config.services.pipewire.enable;
assert nixosConfig.config.services.supergfxd.enable;
assert nixosConfig.config.services.tlp.enable;
assert nixosConfig.config.services.udisks2.enable;
assert nixosConfig.config.programs.virt-manager.enable;
assert nixosConfig.config.programs.rog-control-center.enable;
assert nixosConfig.config.time.timeZone == "Asia/Taipei";
assert nixosConfig.config.networking.networkmanager.enable;
assert nixosConfig.config.virtualisation.libvirtd.enable;
assert nixosConfig.config.virtualisation.spiceUSBRedirection.enable;
assert nixosConfig.config.virtualisation.waydroid.enable;
assert nixosConfig.config.xdg.portal.enable;
assert builtins.elem nixosConfig.config.programs.hyprland.portalPackage
  nixosConfig.config.xdg.portal.extraPortals;
assert nixosConfig.config.programs.wireshark.enable;
assert nixosConfig.config.programs.wireshark.package
  == nixosConfig.pkgs.wireshark-qt;
assert nixosConfig.config.programs.zsh.enable;
assert userConfig.shell == nixosConfig.pkgs.zsh;
assert builtins.elem "adbusers" userConfig.extraGroups;
assert builtins.elem "dialout" userConfig.extraGroups;
assert builtins.elem "uucp" userConfig.extraGroups;
assert builtins.elem "wheel" userConfig.extraGroups;
assert builtins.elem "docker" userConfig.extraGroups;
assert builtins.elem "libvirtd" userConfig.extraGroups;
assert builtins.elem "wireshark" userConfig.extraGroups;
assert nixosConfig.config.zramSwap.enable;
assert !wiresharkOnlyConfig.config.virtualisation.libvirtd.enable;
assert !wiresharkOnlyConfig.config.virtualisation.spiceUSBRedirection.enable;
assert builtins.elem "wireshark"
  wiresharkOnlyConfig.config.users.users.alice.extraGroups;
true
