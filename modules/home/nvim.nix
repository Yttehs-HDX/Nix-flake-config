{ inputs, ... }:

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
      gcc
      clang
      gnumake
      pkg-config
    ];

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    plugins = {
      lualine.enable = true;
      bufferline.enable = true;
      web-devicons.enable = true;
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
          incremental_selection.enable = true;
          indent.enable = true;
        };
      };
      noice.enable = true;
      nvim-tree = {
        enable = true;
        openOnSetup = true;
      };
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "buffer"; }
            { name = "path"; }
            { name = "conventionalcommits"; }
            { name = "git"; }
            { name = "zsh"; }
            { name = "calc"; }
            { name = "emoji"; }
            { name = "copilot"; }
            { name = "treesitter"; }
          ];
          mapping = {
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-conventionalcommits.enable = true;
      cmp-git.enable = true;
      cmp-zsh.enable = true;
      cmp-calc.enable = true;
      cmp-emoji.enable = true;
      copilot-lua = {
        enable = true;
        settings.filetypes = {
          "." = false;
          cvs = false;
          gitcommit = true;
          gitrebase = true;
          help = false;
          hgcommit = false;
          markdown = false;
          svn = false;
          yaml = true;
        };
      };
      copilot-cmp.enable = true;
      copilot-chat.enable = true;
      render-markdown.enable = true;
      markdown-preview.enable = true;
      lsp = {
        enable = true;
        servers = {
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          ts_ls.enable = true;
          lua_ls.enable = true;
          gopls.enable = true;
          clangd.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          bashls.enable = true;
          dockerls.enable = true;
          sqls.enable = true;
          texlab.enable = true;
        };
        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "go" = "type_definition";
            "gr" = "references";
            "K" = "hover";
            "<C-k>" = "signature_help";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>f" = "format";
          };
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>e" = "open_float";
            "<leader>q" = "setloclist";
          };
        };
      };
      notify = {
        enable = true;
        settings.timeout = 500;
      };
      trouble.enable = true;
      nvim-lightbulb.enable = true;
    };
  };
}
