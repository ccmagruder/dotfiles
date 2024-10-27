return {

  "folke/which-key.nvim",

  {
    "folke/neoconf.nvim",
    cmd = "Neoconf"
  },

  "folke/neodev.nvim",

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require('nvim-tree').setup()
    end
  },

  { "earthly/earthly.vim", },

  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.icons').setup()
    end,
  },  -- main branch

  { 'echasnovski/mini.icons', version = false },  -- main branch

  {
    -- fork of 'nordtheme/vim' mapping nord0 color to black
    'ccmagruder/nordtheme-vim',
    config = function()
      vim.cmd.colorscheme 'nord'
    end,
  },
}

