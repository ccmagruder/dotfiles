{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    focusEvents = true;  # needed for pkgs.vimPlugins.vim.tmux-focus-events
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.nord
    ];
  };
}

