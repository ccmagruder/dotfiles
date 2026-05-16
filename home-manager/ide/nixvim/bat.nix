{ pkgs, inputs, ... }:
{
  home.packages = [ pkgs.vimPlugins.plenary-nvim ];

  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "bat.nvim";
        src = inputs.bat-nvim;
      })
    ];

    extraConfigLua = ''
      require("bat").setup(
        { enabled = true }
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
    {
      mode = "n";
      key = "<leader>,";
      action = "<cmd>Bat run<cr>";
      options.desc = "Run BaT Run";
    }
  ];
}
