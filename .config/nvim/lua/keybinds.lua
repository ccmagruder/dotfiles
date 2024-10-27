-- .config/nvim/lua/keybinds/init.lua

require('which-key').add({
  { "<leader>b",  require('nvim-docker').build, desc = "Build" },

  { "<leader>e", require('nvim-tree.api').tree.toggle, desc = "Open Explorer" },

  { "<leader>f", group = "Telescope"},
  { "<leader>ff", require('telescope.builtin').find_files, desc="Find Files" },
  { "<leader>fb", require('telescope.builtin').buffers, desc = "Buffers" },
  { "<leader>fg", require('telescope.builtin').live_grep, desc = "Live Grep" },

  { "<leader>g", require('nvim-docker').toggle_git_diff, desc = "Toggle Gitsigns Highlighting" },

  { "<leader>h", vim.diagnostic.open_float, desc = "Open Diagnostic Float" },

  { "<leader>s", "<cmd>w<cr>", desc = "Write Buffer" },

  { "<leader>t", require('nvim-docker').test, desc = "Test" },

  { "<leader>w", require'nvim-docker'.close_buffer, desc = "Close Buffer" },

  { "<leader>q", "<cmd>qa<cr>", desc = "Exit" },

  { "<leader><tab>", "<cmd>bn<cr>", desc = "Next Buffer" },

  { "<leader>,", require('nvim-docker').run, desc = "Run" },
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
