return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require('nvim-tree').setup({
        renderer = {
          indent_markers = {
            enable = true,
          }
        },
      })
    end
  },
}
