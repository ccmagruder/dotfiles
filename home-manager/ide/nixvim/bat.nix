{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "bat.nvim";
        src = ./bat.nvim;
      })
    ];

    extraConfigLua = ''
      require("bat").setup()
    '';
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Bat<cr>";
      options.desc = "Run BaT";
    }
  ];
}
