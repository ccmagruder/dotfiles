return {
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf"
  },

  "folke/neodev.nvim",

  { "earthly/earthly.vim", },

  {
    'echasnovski/mini.nvim',
    dependencies = {
      { 'echasnovski/mini.icons', version = false },  -- main branch
    },
    version = false,
    config = function()
      require('mini.icons').setup()
    end,
  },  -- main branch


  {
    -- fork of 'nordtheme/vim' mapping nord0 color to black
    'ccmagruder/nordtheme-vim',
    config = function()
      vim.cmd.colorscheme 'nord'
    end,
  },
}

