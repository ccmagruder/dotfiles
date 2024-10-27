return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "cpp", "dockerfile", "earthfile", "python" },
        highlight = {
          enable = true,
        },
      }
    end,
    build = ':TSUpdate',
  },
}

