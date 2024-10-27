return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local custom_theme = require('lualine.themes.nord')
      custom_theme.inactive.a.bg = '#282828'
      custom_theme.inactive.a.fg = '#ffffff'
      require('lualine').setup({
        options = { theme = custom_theme },

        sections = {
          lualine_a = {'mode'},
          lualine_b = {'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'},
        },
        
        tabline = {
          lualine_a = {'buffers'},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'branch'},
        },
      })
    end,
  },
}

