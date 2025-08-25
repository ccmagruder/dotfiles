return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function ()
    require("neotest").setup({
      adapters = {
        require("neotest-python")
      },
      floating = {
        border = "single",
      },
      output = {
        open_on_run = false,
      },
      output_panel = {
        open = "botright vsplit | vertical resize 120",
      },
    })
    require("neotest").output_panel.open()
    require("neotest").summary.open()
  end,
}
