-- .config/nvim/lua/keybinds/init.lua

local function set()
  local function toggle_git_diff()
    local gitsigns = require('gitsigns')
    gitsigns.toggle_linehl()
    gitsigns.toggle_deleted()
  end

  require('which-key').add({
    {
      "<leader>b",
      function()
        require('terminal_cmd')(vim.env["NVIM_BUILD_CMD"])
      end,
      desc = "Build"
    },

    { "<leader>e", require('nvim-tree.api').tree.toggle, desc = "Open Explorer" },

    { "<leader>f", group = "Telescope"},
    { "<leader>ff", require('telescope.builtin').find_files, desc="Find Files" },
    { "<leader>fb", require('telescope.builtin').buffers, desc = "Buffers" },
    { "<leader>fg", require('telescope.builtin').live_grep, desc = "Live Grep" },

    { "<leader>g", toggle_git_diff, desc = "Toggle Gitsigns Highlighting" },

    { "<leader>h", vim.diagnostic.open_float, desc = "Open Diagnostic Float" },

    { "<leader>s", "<cmd>w<cr>", desc = "Write Buffer" },

    {
      "<leader>t",
      function()
        require('terminal_cmd')(vim.env["NVIM_TEST_CMD"])
      end,
      desc = "Test"
    },

    { "<leader>w", require('close_buffer'), desc = "Close Buffer" },

    { "<leader>q", "<cmd>qa<cr>", desc = "Exit" },

    { "<leader><tab>", "<cmd>bn<cr>", desc = "Next Buffer" },

    {
      "<leader>,",
      function()
        require('terminal_cmd')(vim.env["NVIM_RUN_CMD"])
      end,
      desc = "Run"
    },
  })

  vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
  -- Disabled because it overwrites keymaps from christoomey/vim-tmux-navigator plugin
  -- vim.keymap.set('n', "<C-h>", [[<C-w>h]])
  -- vim.keymap.set('n', "<C-j>", [[<C-w>j]])
  -- vim.keymap.set('n', "<C-k>", [[<C-w>k]])
  -- vim.keymap.set('n', "<C-l>", [[<C-w>l]])

  -- Adding insert mode bindings to escape to normal mode and navigate
  vim.keymap.set('i', "<C-h>", [[<esc><cmd>TmuxNavigateLeft<cr>]])
  vim.keymap.set('i', "<C-j>", [[<esc><cmd>TmuxNavigateDown<cr>]])
  vim.keymap.set('i', "<C-k>", [[<esc><cmd>TmuxNavigateUp<cr>]])
  vim.keymap.set('i', "<C-l>", [[<esc><cmd>TmuxNavigateRight<cr>]])

  vim.keymap.del('n', 'gcc')
  vim.keymap.set('n', 'gn', vim.cmd.cnext)
  vim.keymap.set('n', 'gp', vim.cmd.cprev)
  vim.keymap.set('n', 'gq', vim.cmd.ccl)

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

  vim.keymap.set('n', 'ra', "<cmd>MoltenReevaluateAll<cr>", { desc = "Run All Cells" })
  vim.keymap.set('n', 'rh', "<cmd>MoltenHideOutput<cr>", { desc = "Hide Output" })
  vim.keymap.set('n', 'rk', "<cmd>MoltenRestart<cr>", { desc = "Restart Kernel" })
  vim.keymap.set('n', 'ro', "<cmd>MoltenShowOutput<cr><cmd>noautocmd MoltenEnterOutput<cr>", { desc = "Enter Cell Output" })
  vim.keymap.set('n', 'rr', "<cmd>MoltenEvaluateOperator<cr><cmd>call feedkeys(\"ip\")<cr>", { desc = "Run Cell" })


end

return { set = set }
