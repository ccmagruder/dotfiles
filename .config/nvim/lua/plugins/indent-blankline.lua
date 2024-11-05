return {
  {
    "lukas-reineke/indent-blankline.nvim",
    tag = 'v3.8.2',
    enabled = true,
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      local highlight = {
            "Frost1",
            "Frost2",
            "Frost3",
            "Frost4",
        }

        local hooks = require "ibl.hooks"
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "Frost1", { fg = "#5E81AC" })
          vim.api.nvim_set_hl(0, "Frost2", { fg = "#81A1C1" })
          vim.api.nvim_set_hl(0, "Frost3", { fg = "#88C0D0" })
          vim.api.nvim_set_hl(0, "Frost4", { fg = "#8FBCBB" })
        end)

        require("ibl").setup {
          indent = { highlight = highlight },
        }
    end,
  },
}
