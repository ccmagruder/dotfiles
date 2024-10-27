-- .config/nvim/lua/keybinds/init.lua

require('which-key').add({
  { "<leader>b",  function() require('nvim-docker').build() end, desc = "Build" },

  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open Explorer" },

  { "<leader>f", group = "Telescope"},
  { "<leader>ff", "<cmd>Telescope find_files hidden=True<cr>", desc="File" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffer" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },

  { "<leader>g", function() require('nvim-docker').toggle_git_diff() end, desc = "Toggle Gitsigns Highlighting" },

  { "<leader>h", function() vim.diagnostic.open_float() end, desc = "Open Diagnostic Float" },

  { "<leader>n", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Git Change" },

  { "<leader>s", "<cmd>w<cr>", desc = "Write Buffer" },

  { "<leader>t", function() require('nvim-docker').test() end, desc = "Test" },

  { "<leader>w", function() require'nvim-docker'.close_buffer() end, desc = "Close Buffer" },

  { "<leader>q", "<cmd>qa<cr>", desc = "Exit" },

  { "<leader><tab>", "<cmd>bn<cr>", desc = "Next Buffer" },

  { "<leader>,", function() require('nvim-docker').run() end, desc = "Run" },
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
