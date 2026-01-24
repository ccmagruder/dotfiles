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
  ];

  home.packages = with pkgs; [ ripgrep fd ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;
    colorschemes.nord.enable = true;
    plugins = {
      nvim-tree.enable = true;
      web-devicons.enable = true;
      tmux-navigator.enable = true;
      indent-blankline.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          nixd = {
            enable = true;
            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
              formatting.command = [ "nixfmt" ];
              options = {
                nixos.expr = ''(builtins.getFlake "/etc/nixos").nixosConfigurations.nixos.options'';
              };
            };
          };
        };
        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
          lspBuf = {
            "gd" = "definition";
            "K" = "hover";
            "<leader>ca" = "code_action"; # Useful for ni'ls refactoring
            "<leader>rn" = "rename";
          };
        };
      };
      telescope = {
        enable = true;
        settings.defaults.vimgrep_arguments = [
          "rg" "--color=never" "--no-heading" "--with-filename"
          "--line-number" "--column" "--smart-case" "--hidden"
        ];
      };
      lualine = {
        enable = true;
        settings = {
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostic" ];
            lualine_c = [ 
              {
                __unkeyed-1 = "filename";
                newfile_status = true;
                path = 3;
              }
            ];
            lualine_x = [ "filetype" ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
          tabline = {
            lualine_a = [ "buffers" ];
            lualine_b = [ ];
            lualine_c = [ ];
            lualine_x = [ ];
            lualine_y = [ ];
            lualine_z = [ "branch" ];
          };
        };
      };
    };

    extraPlugins = [
      pkgs.vimPlugins.vim-tmux-focus-events
      pkgs.vimPlugins.bufdelete-nvim
    ];

    autoCmd = [
      # {
      #   event = "FocusGained";
      #   pattern = "*";
      #   command = "silent !tmux resize-pane -Z";
      # }
    ];

    globals.mapleader = " ";
    globals.maplocalleader = " ";
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
      }
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
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>Bdelete<cr>";
        options.desc = "Delete buffer, keep window";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Telescope: Live Grep";
      }
    ];
    opts = {
      tabstop = 2;
      expandtab = true;
      shiftwidth = 2;
      autoread = true;
    };
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" }) -- background black
    '';
  };
}
