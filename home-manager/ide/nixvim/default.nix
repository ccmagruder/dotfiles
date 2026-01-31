{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./bat.nix
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
      winhighlight = "Normal:Normal,NormalNC:NormalNC";
    };

    # Color Theme
    colorschemes.nord.enable = true;
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" }) -- background black
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a1a" }) -- dimmed background for inactive windows
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#000000" }) -- nvim-tree active background
      vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#1a1a1a" }) -- nvim-tree inactive background (dimmed)

      -- Dim all neovim windows when losing focus to another tmux pane
      local focus_group = vim.api.nvim_create_augroup("TmuxFocusDim", { clear = true })

      vim.api.nvim_create_autocmd("FocusLost", {
        group = focus_group,
        callback = function()
          vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1a1a" })
          vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#1a1a1a" })
          -- Dim lualine by setting all sections to use inactive colors
          vim.opt.winhl:append("StatusLine:StatusLineNC")
        end,
      })

      vim.api.nvim_create_autocmd("FocusGained", {
        group = focus_group,
        callback = function()
          vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
          vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#000000" })
          -- Restore lualine active colors
          vim.opt.winhl:remove("StatusLine:StatusLineNC")
        end,
      })
    '';

    # Plugins, see imports for additional plugins
    plugins = {
      web-devicons.enable = true;
      tmux-navigator = {
        enable = true;
        settings.no_wrap = true;
      };
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
      # tmux-navigator from insert mode
      {
        mode = "i";
        key = "<C-h>";
        action = "<Esc>:TmuxNavigateLeft<CR>";
      }
      {
        mode = "i";
        key = "<C-j>";
        action = "<Esc>:TmuxNavigateDown<CR>";
      }
      {
        mode = "i";
        key = "<C-k>";
        action = "<Esc>:TmuxNavigateUp<CR>";
      }
      {
        mode = "i";
        key = "<C-l>";
        action = "<Esc>:TmuxNavigateRight<CR>";
      }
    ];
  };
}
