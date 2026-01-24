{ pkgs, ... }:
{
  home.packages = with pkgs; [ ripgrep fd ];
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings.defaults = {
      vimgrep_arguments = [
        "rg" "--color=never" "--no-heading" "--with-filename"
        "--line-number" "--column" "--smart-case" "--hidden"
      ];
      file_ignore_patterns = [ ".git/" ];
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Telescope: Live Grep";
    }
  ];
}
