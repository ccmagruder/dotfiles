{ pkgs, ... }:
{
  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "ccmagruder";
      core.editor = "nvim";
      core.pager = "less -FRX";
    };
  };
}
