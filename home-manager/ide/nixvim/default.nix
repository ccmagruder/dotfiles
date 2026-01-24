{ pkgs, ... }:
let
  nixvim = import (
    builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      rev = "f1e07ba53abd0fb4872a365cba45562144ad6130";
    }
  );
in
{
  imports = [
    nixvim.homeModules.nixvim
    ./bufdelete.nix
    ./gitsigns.nix
    ./lsp.nix
    ./lualine.nix
    ./nvim-tree.nix
    ./telescope.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;

    # Vim Options
    opts = {
      number = true;
      tabstop = 2;
      expandtab = true;
      shiftwidth = 2;
      autoread = true;
    };

    # Color Theme
    colorschemes.nord.enable = true;
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" }) -- background black
    '';

    # Plugins, see imports for additional plugins
    plugins = {
      web-devicons.enable = true;
      tmux-navigator.enable = true;
      indent-blankline.enable = true;
    };

    # Auto-save
    autoCmd = [
      {
        event = "FocusLost";
        pattern = "*";
        command = "wa";
      }
    ];

    # Keyboard shortcuts
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    keymaps = [
      {
        mode = "n";
        key = "<leader><Tab>";
        action = "<cmd>bn<CR>";
      }
      {
        mode = "n";
        key = "<leader>s";
        action = "<cmd>w<CR>";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>qa<CR>";
      }
    ];
  };
}
