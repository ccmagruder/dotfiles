return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = {".git/.*"},
        },
        pickers = {
          live_grep = {
            additional_args = function(opts)
              return {"--hidden"}
            end
          },
          find_files = {
            additional_args = function(opts)
              return {"--hidden"}
            end
          },
        },
      }
    end,
  },
}
