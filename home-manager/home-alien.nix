{ pkgs, ... }:
{
  home.username = "remote";
  home.homeDirectory = "/home/remote";
  programs.zsh.envExtra = "export STARSHIP_HOST_ALIAS=alien";

  programs.git.settings.user.email = "ccmagruder@gmail.com";

  home.packages = [ pkgs.podman-compose ];
}
