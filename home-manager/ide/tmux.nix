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

      # vim-tmux-navigator with no-wrap
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      bind-key -n C-h if-shell "$is_vim" "send-keys C-h" "if-shell '[ #{pane_at_left} -eq 0 ]' 'select-pane -L'"
      bind-key -n C-j if-shell "$is_vim" "send-keys C-j" "if-shell '[ #{pane_at_bottom} -eq 0 ]' 'select-pane -D'"
      bind-key -n C-k if-shell "$is_vim" "send-keys C-k" "if-shell '[ #{pane_at_top} -eq 0 ]' 'select-pane -U'"
      bind-key -n C-l if-shell "$is_vim" "send-keys C-l" "if-shell '[ #{pane_at_right} -eq 0 ]' 'select-pane -R'"

      bind-key -T copy-mode-vi C-h if-shell "[ #{pane_at_left} -eq 0 ]" "select-pane -L"
      bind-key -T copy-mode-vi C-j if-shell "[ #{pane_at_bottom} -eq 0 ]" "select-pane -D"
      bind-key -T copy-mode-vi C-k if-shell "[ #{pane_at_top} -eq 0 ]" "select-pane -U"
      bind-key -T copy-mode-vi C-l if-shell "[ #{pane_at_right} -eq 0 ]" "select-pane -R"
    '';
  };
}

