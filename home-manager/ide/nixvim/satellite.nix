{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.satellite-nvim ];
    extraConfigLua = "require('satellite').setup({})";
  };
}
