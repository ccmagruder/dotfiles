{ pkgs, ... }:
{
  home.username = "remote";
  home.homeDirectory = "/home/remote";

  programs.git.settings.user.email = "ccmagruder@gmail.com";

  home.packages = [ pkgs.podman-compose ];
}
