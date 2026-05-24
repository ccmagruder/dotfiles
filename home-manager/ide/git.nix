{ config, pkgs, ... }:
{
  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "ccmagruder";
      user.email = "ccmagruder@gmail.com";
      core.editor = "nvim";
      core.pager = "less -FRX";
    };
  };
}
