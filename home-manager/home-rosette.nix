{ ... }:
{
  home.username = "caleb.magruder";
  home.homeDirectory = "/home/caleb.magruder";

  programs.git.settings.user.email = "caleb.magruder@simplerose.com";

  # Appends PATH with nix commands and installed binaries such as nvim.
  # Since nix on rosette is installed single-user, these commands are not added
  # system-wide in /etc/profile.
  programs.zsh.envExtra = ''
    if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
  '';
}
