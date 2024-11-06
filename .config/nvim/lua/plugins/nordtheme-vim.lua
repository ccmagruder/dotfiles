return {
  {
    -- fork of 'nordtheme/vim' mapping nord0 color to black
    'ccmagruder/nordtheme-vim',
    config = function()
      vim.cmd.colorscheme 'nord'
    end,
  },
}
