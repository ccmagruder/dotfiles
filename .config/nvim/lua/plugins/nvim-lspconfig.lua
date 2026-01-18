return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('lua_ls',
        {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        }
      )
      vim.lsp.config('yamlls', {settings = {}})
      vim.lsp.config('pylsp', {
        settings = {
          pylsp = {
            plugins = {
              pylsp_mypy = {
                enabled = true,
                -- Does not work if both live_mode and dmypy are true
                live_mode = false, -- Check as you type
                dmypy = true, -- Use the mypy daemon for speed
              },
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
            },
          },
        },
      })
      vim.lsp.enable('pylsp')
    end
  },
}
