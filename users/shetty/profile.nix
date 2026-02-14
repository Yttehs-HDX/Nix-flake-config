{ ... }:

{
  user = {
    username = "shetty";
    description = "Shetty Yttehs";
    isSuper = true;
  };

  desktop = {
    enable = true;

    sessions.hyprland.enable = true;

    style = {
      theme = {
        name = "catppuccin";
        accent = "lavender";
        flavor = "mocha";
      };

      fonts = {
        default = "SF Pro";
        mono = { default = "JetBrainsMono Nerd Font"; };
        nerd-fonts-jetbrains-mono.enable = true;
        noto-fonts.enable = true;
        noto-fonts-cjk-sans.enable = true;
        noto-fonts-cjk-serif.enable = true;
        noto-fonts-emoji-blob-bin.enable = true;
      };
    };

    aux = {
      udisks2.enable = true;
      network-manager.enable = true;
      blueman.enable = true;
      gnome-keyring.enable = true;
      pipewire.enable = true;
      fcitx5.enable = true;
      pulseaudio.enable = true;
      libnotify.enable = true;
      vlc.enable = true;
      seahorse.enable = true;
    };
  };

  home.software = {
    zsh.enable = true;
    kitty.enable = true;
    kdeconnect.enable = true;

    yazi.enable = true;
    eza.enable = true;
    fzf.enable = true;
    direnv.enable = true;
    copilot-cli.enable = true;
    tmux.enable = true;
    git.enable = true;
    lazygit.enable = true;
    gh.enable = true;
    vscode.enable = true;
    translate-shell.enable = true;
    cava.enable = true;
    btop.enable = true;
    htop.enable = true;
    onlyoffice.enable = true;
    obs-studio.enable = true;
    neovim.enable = true;
    net-tools.enable = true;
    nix-index.enable = true;
    file.enable = true;

    bat.enable = true;

    zip.enable = true;
    unzip.enable = true;
    unrar.enable = true;
    duf.enable = true;
    dig.enable = true;
    jq.enable = true;
    fastfetch.enable = true;
    tldr.enable = true;
    tgpt.enable = true;
    scrcpy.enable = true;
    hexecute.enable = true;
    krita.enable = true;
    mikusays.enable = true;
    figlet.enable = true;
    lolcat.enable = true;
    poppler-utils.enable = true;
    ripgrep.enable = true;
    cryptsetup.enable = true;

    nmap.enable = true;
    wget.enable = true;
    android-tools.enable = true;
    universal-android-debloater.enable = true;
    nixfmt-classic.enable = true;
    huggingface-hub.enable = true;

    feishu.enable = true;

    asciiquarium.enable = true;
    hmcl.enable = true;
    cmatrix.enable = true;
    cbonsai.enable = true;
    pipes-rs.enable = true;

    google-chrome.enable = true;
    clash-verge-rev.enable = true;
    qq.enable = true;
    wechat.enable = true;
    osu-lazer-bin.enable = true;
    jetbrains-toolbox.enable = true;
  };
}
