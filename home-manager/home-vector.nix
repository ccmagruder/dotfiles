{ ... }:
{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";
  programs.zsh.envExtra = ''
    export STARSHIP_HOST_ALIAS=vector
    export PATH="/usr/lib/ccache:$PATH"
  '';

  programs.git.settings.user.email = "caleb.magruder@simplerose.com";
}
