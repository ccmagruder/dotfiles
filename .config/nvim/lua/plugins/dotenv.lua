return {
  {
    'ellisonleao/dotenv.nvim',
    config = function()
      require('dotenv').setup({
        event = "BufWritePost",
        enable_on_load = true,
        verbose = false,
      })
    end
  },
}
