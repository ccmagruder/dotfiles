-- lazyvim setup

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
vim.api.nvim_set_option_value("expandtab", true, {})
vim.api.nvim_set_option_value("shiftwidth", 2, {})
vim.api.nvim_set_option_value("tabstop", 2, {})
vim.api.nvim_set_option_value("number", true, {})
vim.api.nvim_set_option_value("relativenumber", true, {})
vim.api.nvim_set_option_value("cursorline", true, {})

vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "CursorHoldI"}, {
  pattern={"*"},
  command="silent! checktime",
})
vim.o.updatetime = 100
-- autocmd CursorHold * silent! checktime

-- calls .config/nvim/lua/plugins.lua
require("lazy").setup("plugins")

-- Configure diagnostic message window with borders, mapped to <leader>h in keybinds.lua
vim.diagnostic.config(
  {
    float = { border = "rounded" },
  }
)

-- Environment vars NVIM_{BUILD,TEST,RUN}_CMD are loaded via 'ellisonleao/dotenv.nvim'
if vim.env["NVIM_BUILD_CMD"] == nil then
  vim.env["NVIM_BUILD_CMD"] = "echo 'Set vim.env[\"NVIM_BUILD_CMD\"] to configure build.'"
end

if vim.env["NVIM_TEST_CMD"] == nil then
  vim.env["NVIM_TEST_CMD"] = "echo 'Set vim.env[\"NVIM_TEST_CMD\"] to configure test.'"
end

if vim.env["NVIM_RUN_CMD"] == nil then
  vim.env["NVIM_RUN_CMD"] = "echo 'Set vim.env[\"NVIM_RUN_CMD\"] to configure run.'"
end

