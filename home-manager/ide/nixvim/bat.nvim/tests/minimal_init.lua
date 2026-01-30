vim.opt.rtp:prepend(vim.env.PLENARY_PATH)
vim.opt.rtp:prepend(vim.env.BAT_PATH)
vim.cmd("source " .. vim.env.PLENARY_PATH .. "/plugin/plenary.vim")
