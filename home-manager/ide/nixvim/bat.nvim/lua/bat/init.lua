local M = {}

local config = require("bat.config")
local commands = require("bat.commands")

function M.setup(opts)
  if opts and opts.enabled then
    local options = config.setup(opts)
    commands.setup(options)
  end
end

function M.read_json_config(filepath)
  local fullpath = vim.fn.expand(filepath)
  local content = table.concat(vim.fn.readfile(fullpath), "\n")
  M.data = vim.fn.json_decode(content)
end

function M.open_window()
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local ok, is_bat = pcall(vim.api.nvim_win_get_var, win_id, "is_bat_window")
    print(ok)
    print(win_id)
    if ok and is_bat then
      print("window already open")
      return
    end
  end
  vim.cmd("rightbelow vsplit")
  local bat_window = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_var(bat_window, "is_bat_window", true)
end

return M
