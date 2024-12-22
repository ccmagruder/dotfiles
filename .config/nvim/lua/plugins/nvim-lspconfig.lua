return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- require('lspconfig').ccls.setup({})
      require('lspconfig').clangd.setup({})
      require('lspconfig').pyright.setup({})
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end
  },
}
