{
  enable = true;

  meta = {
    displayName = "Shetty";
    description = "Primary user profile.";
    tags = [ "primary-user" ];
  };

  preferences = {
    shell = "zsh";
    editor = "nvim";
    terminal = "kitty";
  };

  initialHashedPassword =
    "$y$j9T$IbyB4U5AIUqcxol3JR60E0$/Wr3iDHuKpYBX7lkBSMJHGWlRS3quNv.DqQvkpKK4dD";

  capabilities = {
    desktop.enable = true;
    development.enable = false;
    theme.enable = true;
  };

  packages = {
    android-tools = { };
    asciiquarium = { };
    bat = { };
    brightnessctl = { };
    btop = { };
    cava = { };
    cbonsai = { };
    clash-verge-rev = { };
    claude-code = { };
    cmatrix = { };
    codex = { };
    cryptsetup = { };
    dig = { };
    direnv = { };
    duf = { };
    embedded-dev = { };
    ettercap = { };
    ethtool = { };
    hping = { };
    eza = { };
    fastfetch = { };
    feishu = { };
    fcitx5 = { };
    figlet = { };
    file = { };
    ffmpeg = { };
    fzf = { };
    gh = { };
    git = { };
    github-copilot-cli = { };
    gnome-keyring = { };
    google-chrome = { };
    hmcl = { };
    htop = { };
    huggingface-hub = { };
    hyprland = { };
    hypridle = { };
    hyprpicker = { };
    hyprpolkitagent = { };
    jq = { };
    jetbrains-toolbox = { };
    kdeconnect = { };
    keepassxc = { };
    krita = { };
    lazydocker = { };
    lazygit = { };
    libnotify = { };
    lolcat = { };
    metasploit = { };
    nixvim = { };
    net-tools = { };
    network-manager = { };
    nerd-fonts-jetbrains-mono = { };
    nixfmt-classic = { };
    nix-index = { };
    nmap = { };
    nodejs = { };
    noto-fonts = { };
    noto-fonts-cjk-sans = { };
    noto-fonts-cjk-serif = { };
    noto-fonts-emoji-blob-bin = { };
    obs-studio = { };
    obsidian = { settings = { passwordStore = "gnome-libsecret"; }; };
    ollama = { };
    openclaw = { };
    onlyoffice = { };
    osu-lazer-bin = { };
    pipes-rs = { };
    playerctl = { };
    poppler-utils = { };
    pulseaudio = { };
    qbittorrent = { };
    qq = { };
    ripgrep = { };
    rofi = { };
    scrcpy = { };
    seahorse = { };
    wl-clipboard = { };
    rofimoji = { };
    grimblast = { };
    swappy = { };
    ocr = { };
    swaylock-effects = { };
    swaync = { };
    tgpt = { };
    tldr = { };
    tmux = { };
    translate-shell = { };
    udisks2 = { };
    universal-android-debloater = { };
    unimatrix = { };
    unrar = { };
    unzip = { };
    vlc = { };
    vscode = { };
    waybar = { };
    cliphist = { };
    swww = { };
    syncthing = { };
    taplo = { };
    wechat = { };
    wget = { };
    xdg = { };
    yazi = { };
    zip = { };
    "7-zip" = { };
    zsh = { };
    hexecute = { };
    mikusays = { };
    kitty.settings = {
      fontSize = 14.0;
      backgroundOpacity = 0.9;
      backgroundBlur = 1;
      rememberWindowSize = false;
      shellIntegrationMode = "no_cursor";
    };
  };

  theme = {
    name = "catppuccin";
    accent = "lavender";
    flavor = "mocha";
    fonts.sans = "SF Pro";
    fonts.monospace.family = "JetBrainsMono Nerd Font";
  };
}
