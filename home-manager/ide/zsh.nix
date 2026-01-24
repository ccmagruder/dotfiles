{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
      update = "sudo nixos-rebuild test";
      ide = "tmux -u new-session -n nixos -c ~/nixos \"nvim -c NvimTreeToggle\" \\; split-window -v \\; new-window -n dotfiles -c ~/dotfiles \"nvim -c NvimTreeToggle\" \\; split-window -v -c ~/dotfiles";
    };
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };
}
