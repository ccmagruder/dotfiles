-- bat.nvim: Run shell commands in a dedicated terminal window.
-- Commands are defined in a JSON config file (default: .bat.json).

local M = {}

local config = require("bat.config")
local commands = require("bat.commands")

-- Initialize plugin: merge config and register :Bat command.
function M.setup(opts)
  if opts and opts.enabled then
    local options = config.setup(opts)
    commands.setup(options)
  end
end

-- Load command definitions from JSON file.
-- Returns a table mapping command names to shell command strings.
function M.read_json_config(filepath)
  local fullpath = vim.fn.expand(filepath)
  local content = table.concat(vim.fn.readfile(fullpath), "\n")
  local cmds = vim.fn.json_decode(content)
  return cmds
end

-- Get or create the bat terminal window (idempotent).
-- Reuses existing window if found, otherwise creates a vertical split.
-- Window is marked with is_bat_window variable for identification.
function M.open_window()
  -- Check if bat window already exists
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local ok, is_bat = pcall(vim.api.nvim_win_get_var, win_id, "is_bat_window")
    if ok and is_bat then
      return win_id
    end
  end
  -- Create new window, preserving user's cursor position
  local initial_window = vim.api.nvim_get_current_win()
  vim.cmd("rightbelow vsplit")
  local bat_window = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_var(bat_window, "is_bat_window", true)
  vim.api.nvim_set_current_win(initial_window)
  return bat_window
end

-- Execute shell command in the bat terminal window.
-- Cleans up old bat buffers to prevent accumulation.
-- Returns channel info for the terminal process.
function M.run(cmd)
  -- Delete old bat buffers before creating new one
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    local ok, is_bat = pcall(vim.api.nvim_buf_get_var, buf_id, "is_bat_buffer")
    if ok and is_bat then
      vim.api.nvim_buf_delete(buf_id, {force = true})
    end
  end
  -- Run command in bat window, preserving user's cursor position
  local initial_window = vim.api.nvim_get_current_win()
  local bat_window = M.open_window()
  vim.api.nvim_set_current_win(bat_window)
  vim.cmd("enew")
  vim.api.nvim_buf_set_var(0, "is_bat_buffer", true)
  vim.fn.termopen({ "bash", "-c", cmd })
  vim.api.nvim_set_current_win(initial_window)
  -- Return channel info for process monitoring
  local buf = vim.api.nvim_win_get_buf(bat_window)
  local chan_id = vim.bo[buf].channel
  local info = vim.api.nvim_get_chan_info(chan_id)
  return info
end

return M
