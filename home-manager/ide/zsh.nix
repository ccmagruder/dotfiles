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
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$nix_shell$python$directory$git_branch$git_status$git_state$character";
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
