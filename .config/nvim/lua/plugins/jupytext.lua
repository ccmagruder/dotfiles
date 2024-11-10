return {
  {
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup({ style = "percent" })
    end,
  },
}
