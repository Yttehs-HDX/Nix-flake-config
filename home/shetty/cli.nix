{ pkgs, ... }:

{
  programs = {
    bat.enable = true;
    eza = {
      enable = true;
      icons = "always";
      git = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    htop.enable = true;
    lazydocker.enable = true;
    lazygit.enable = true;
    lazygit.enableZshIntegration = true;
    ripgrep.enable = true;
    yazi.enable = true;
    yazi.enableZshIntegration = true;
  };

  home.sessionVariables.PAGER = "${pkgs.bat}/bin/bat";

  services = {
    cliphist.enable = true;

    hypridle = {
      enable = true;
      package = pkgs.hypridle;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "swaylock-themed";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "swaylock-themed";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };

    hyprpolkitagent = {
      enable = true;
      package = pkgs.hyprpolkitagent;
    };
  };

  home.packages = with pkgs; [
    android-tools
    asciiquarium
    brightnessctl
    cbonsai
    clash-verge-rev
    claude-code
    cmatrix
    codex
    cryptsetup
    dig
    duf
    ethtool
    ettercap
    fastfetch
    feishu
    ffmpeg
    figlet
    file
    github-copilot-cli
    google-chrome
    grimblast
    hmcl
    hping
    python313Packages.huggingface-hub
    hyprpicker
    jetbrains-toolbox
    jmtpfs
    jq
    krita
    libnotify
    lolcat
    metasploit
    net-tools
    nmap
    noto-fonts-emoji-blob-bin
    nixfmt-classic
    obs-studio
    osu-lazer-bin
    pipes-rs
    playerctl
    poppler-utils
    pulseaudio
    qbittorrent
    qq
    rofimoji
    scrcpy
    seahorse
    swappy
    tesseract
    tgpt
    tldr
    translate-shell
    universal-android-debloater
    unimatrix
    unrar
    unzip
    usbutils
    vlc
    wechat
    wget
    wl-clipboard
    zip
    p7zip
    _7zz
  ];
}
