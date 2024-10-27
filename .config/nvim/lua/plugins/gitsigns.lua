return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        show_deleted = false, -- gets toggled with nvim-docker.toggle_git_diff
        signs = {
          add = { text = '+' },
          change = { text = '~' },
        },
        numhl = true,  --line numbers get highligted
        linehl = false,  -- gets toggled with nvim-docker.toggle_git_diff
        -- base = "HEAD",
      }
    end,
  },
}
