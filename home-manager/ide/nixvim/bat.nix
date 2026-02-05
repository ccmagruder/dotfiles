{ pkgs, lib, ... }:
{
  home.packages = [ pkgs.vimPlugins.plenary-nvim ];

  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "bat.nvim";
        src = ./bat.nvim;
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
  ];

  home.activation.bat-nvim-tests = let
    batPath = builtins.toString ./bat.nvim;
  in lib.hm.dag.entryAfter ["writeBoundary"] ''
    export BAT_PATH="${batPath}"
    export PLENARY_PATH="${pkgs.vimPlugins.plenary-nvim}"
    # invalid directory on purpose, doesn't actually get called
    # this override causes it to not load the ~/.config directory
    export XDG_CONFIG_HOME="/tmp/nvim-test-$$"
    ${pkgs.neovim-unwrapped}/bin/nvim --headless \
      -u "${batPath}/tests/minimal_init.lua" \
      -c "PlenaryBustedDirectory ${batPath}/tests/" \
      || exit 1
  '';
}
