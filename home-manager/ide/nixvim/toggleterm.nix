{ ... }:
{
  programs.nixvim.plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      float_opts = {
        border = "curved";
        width.__raw = "function() return math.floor(vim.o.columns * 0.8) end";
        height.__raw = "function() return math.floor(vim.o.lines * 0.8) end";
      };
      hide_numbers = true;
      shade_terminals = false;
      start_in_insert = false;
      close_on_exit = true;
      shell = "zsh";
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<C-Space>";
      action.__raw = ''
        function()
          vim.cmd("ToggleTerm")
          vim.schedule(function()
            if vim.bo.buftype == "terminal" then
              vim.cmd("startinsert")
            end
          end)
        end
      '';
      options.desc = "Toggle floating terminal";
    }
    {
      mode = "t";
      key = "<C-Space>";
      action = "<C-\\><C-n><cmd>ToggleTerm<CR>";
      options.desc = "Close floating terminal";
    }
    # tmux-navigator from terminal mode (bypass neovim, talk to tmux directly)
    {
      mode = "t";
      key = "<C-h>";
      action.__raw = ''function() vim.fn.system("tmux select-pane -L") end'';
    }
    {
      mode = "t";
      key = "<C-j>";
      action.__raw = ''function() vim.fn.system("tmux select-pane -D") end'';
    }
    {
      mode = "t";
      key = "<C-k>";
      action.__raw = ''function() vim.fn.system("tmux select-pane -U") end'';
    }
    {
      mode = "t";
      key = "<C-l>";
      action.__raw = ''function() vim.fn.system("tmux select-pane -R") end'';
    }
  ];
}
