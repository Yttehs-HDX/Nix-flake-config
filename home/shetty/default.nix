{ inputs, ... }:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/zsh.nix
    ../../modules/home/nvim.nix
    ../../modules/home/kitty.nix
    ../../modules/home/tmux.nix
    ../../modules/home/btop.nix
    ../../modules/home/cava.nix
    ../../modules/home/openclaw.nix
    ../../modules/home/clash-verge-rev.nix
    ../../modules/home/bat.nix
    ../../modules/home/direnv.nix
    ../../modules/home/eza.nix
    ../../modules/home/fzf.nix
    ../../modules/home/gh.nix
    ../../modules/home/htop.nix
    ../../modules/home/lazydocker.nix
    ../../modules/home/lazygit.nix
    ../../modules/home/nix-index.nix
    ../../modules/home/onlyoffice.nix
    ../../modules/home/ripgrep.nix
    ../../modules/home/vscode.nix
    ../../modules/home/yazi.nix
    ../../modules/home/kdeconnect.nix
    ../../modules/home/ollama.nix
    ../../modules/home/syncthing.nix
    ../../modules/home/_7zz.nix
    ../../modules/home/android-tools.nix
    ../../modules/home/asciiquarium.nix
    ../../modules/home/cbonsai.nix
    ../../modules/home/claude-code.nix
    ../../modules/home/cmatrix.nix
    ../../modules/home/codex.nix
    ../../modules/home/cryptsetup.nix
    ../../modules/home/dig.nix
    ../../modules/home/duf.nix
    ../../modules/home/ethtool.nix
    ../../modules/home/ettercap.nix
    ../../modules/home/fastfetch.nix
    ../../modules/home/feishu.nix
    ../../modules/home/ffmpeg.nix
    ../../modules/home/figlet.nix
    ../../modules/home/file.nix
    ../../modules/home/github-copilot-cli.nix
    ../../modules/home/google-chrome.nix
    ../../modules/home/hexecute.nix
    ../../modules/home/hmcl.nix
    ../../modules/home/hping.nix
    ../../modules/home/huggingface-hub.nix
    ../../modules/home/jetbrains-toolbox.nix
    ../../modules/home/jmtpfs.nix
    ../../modules/home/jq.nix
    ../../modules/home/keepassxc.nix
    ../../modules/home/krita.nix
    ../../modules/home/libnotify.nix
    ../../modules/home/lolcat.nix
    ../../modules/home/metasploit.nix
    ../../modules/home/mikusays.nix
    ../../modules/home/net-tools.nix
    ../../modules/home/nixfmt.nix
    ../../modules/home/nmap.nix
    ../../modules/home/nodejs.nix
    ../../modules/home/noto-fonts-emoji-blob-bin.nix
    ../../modules/home/obsidian.nix
    ../../modules/home/obs-studio.nix
    ../../modules/home/osu-lazer-bin.nix
    ../../modules/home/p7zip.nix
    ../../modules/home/pipes-rs.nix
    ../../modules/home/poppler-utils.nix
    ../../modules/home/qbittorrent.nix
    ../../modules/home/qq.nix
    ../../modules/home/scrcpy.nix
    ../../modules/home/seahorse.nix
    ../../modules/home/taplo.nix
    ../../modules/home/tesseract.nix
    ../../modules/home/tgpt.nix
    ../../modules/home/tldr.nix
    ../../modules/home/translate-shell.nix
    ../../modules/home/unimatrix.nix
    ../../modules/home/universal-android-debloater.nix
    ../../modules/home/unrar.nix
    ../../modules/home/unzip.nix
    ../../modules/home/usbutils.nix
    ../../modules/home/vlc.nix
    ../../modules/home/wechat.nix
    ../../modules/home/wget.nix
    ../../modules/home/zip.nix
  ];

  home.username = "shetty";
  home.homeDirectory = "/home/shetty";

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
