{ ... }:
{
  programs.nixvim = {
    plugins.tmux-navigator = {
      enable = true;
      settings.no_wrap = 1;
      settings.no_mappings = 1;
    };
    keymaps = [
      # tmux-navigator from normal mode
      {
        mode = "n";
        key = "<C-h>";
        action = "<cmd>TmuxNavigateLeft<CR>";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<cmd>TmuxNavigateDown<CR>";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<cmd>TmuxNavigateUp<CR>";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<cmd>TmuxNavigateRight<CR>";
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
  };
}
