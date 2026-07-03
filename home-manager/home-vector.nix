{ ... }:
{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";
  programs.zsh.envExtra = "export STARSHIP_HOST_ALIAS=vector";

  programs.git.settings.user.email = "caleb.magruder@simplerose.com";
}
