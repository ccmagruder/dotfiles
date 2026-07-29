{ ... }:
{
  home.username = "caleb.magruder";
  home.homeDirectory = "/home/caleb.magruder";
  programs.git.settings.user.email = "caleb.magruder@simplerose.com";

  home.sessionVariables = {
    TZ = "America/Chicago";
  };

  programs.tmux.extraConfig = ''
    set -g status-right "#{prefix_highlight}#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] #(TZ=America/Chicago date +'%%Y-%%m-%%d') #[fg=white,bg=brightblack,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] #(TZ=America/Chicago date +'%%I:%%M %%p') "
  '';

  # Appends PATH with nix commands and installed binaries such as nvim.
  # Since nix on rosette is installed single-user, these commands are not added
  # system-wide in /etc/profile.
  programs.zsh.envExtra = ''
    export STARSHIP_HOST_ALIAS=rosette
    if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
  '';
}
