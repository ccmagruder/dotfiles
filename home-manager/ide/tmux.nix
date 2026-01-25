{ pkgs, ... }:
{
  home.packages = with pkgs; [ tmux smug ];
  programs.tmux = {
    enable = true;
    mouse = true;
    focusEvents = true;  # needed for pkgs.vimPlugins.vim.tmux-focus-events
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.nord
    ];
    extraConfig = ''
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}

