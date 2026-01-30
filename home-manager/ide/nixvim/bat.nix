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
      require("bat").setup(
        { enabled = true, path = "ide/nixvim/.bat.json" }
      )
    '';
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Bat build<cr>";
      options.desc = "Run BaT Build";
    }
    {
      mode = "n";
      key = "<leader>t";
      action = "<cmd>Bat test<cr>";
      options.desc = "Run BaT Test";
    }
  ];
}
