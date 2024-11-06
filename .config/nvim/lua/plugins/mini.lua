return {
  {
    'echasnovski/mini.nvim',
    dependencies = {
      { 'echasnovski/mini.icons', version = false },  -- main branch
    },
    version = false,  -- main branch
    config = function()
      require('mini.icons').setup()
    end,
  },
}
