{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
      update = "sudo nixos-rebuild test";
      ide = "smug start";
    };
    enableCompletion = true;
    initExtra = ''
      # SSH_AUTH_SOCK goes stale in long-lived tmux sessions after reconnecting.
      # Fix: point SSH_AUTH_SOCK at a fixed symlink; update the symlink each new
      # shell so existing panes automatically pick up the fresh agent socket.
      if [[ -n "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" != "$HOME/.ssh/auth_sock" ]]; then
        ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/auth_sock"
        export SSH_AUTH_SOCK="$HOME/.ssh/auth_sock"
      fi
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "\${env_var.STARSHIP_HOST_ALIAS}$nix_shell$python$directory$git_branch$git_status$git_state$character";
      env_var.STARSHIP_HOST_ALIAS.format = "[$env_value](bold #EBCB8B) ";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      python = {
        format = "[(\\($virtualenv\\))]($style) ";
        detect_files = [];
        detect_extensions = [];
        detect_folders = [];
      };
      nix_shell = {
        disabled = false;
        symbol = "❄️";
        format = "[$symbol]($style) ";
      };
      git_branch = {
        format = "[$branch]($style) ";
      };
      git_state = {
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
      };
      git_status = {
        format = "([$staged$modified$untracked]($style) )";
        staged = "+";
        modified = "!";
        untracked = "?";
      };
    };
  };
}
