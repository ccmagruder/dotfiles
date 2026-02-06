-- bat.nvim: Run shell commands in a dedicated terminal window.
-- Commands are defined in a JSON config file (default: .bat.json).

local M = {}

local config = require("bat.config")
local commands = require("bat.commands")

-- Find existing bat window by checking for is_bat_window variable.
local function find_bat_window()
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local ok, is_bat = pcall(vim.api.nvim_win_get_var, win_id, "is_bat_window")
    if ok and is_bat then
      return win_id
    end
  end
  return nil
end

-- Create a new bat window, preserving user's cursor position.
local function create_bat_window()
  local initial_window = vim.api.nvim_get_current_win()
  vim.cmd("rightbelow vsplit")
  local bat_window = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_var(bat_window, "is_bat_window", true)
  vim.api.nvim_set_current_win(initial_window)
  return bat_window
end

-- Delete all bat buffers to prevent accumulation.
local function delete_bat_buffers()
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    local ok, is_bat = pcall(vim.api.nvim_buf_get_var, buf_id, "is_bat_buffer")
    if ok and is_bat then
      vim.api.nvim_buf_delete(buf_id, {force = true})
    end
  end
end

-- Get channel info for the terminal in a window.
local function get_channel_info(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local chan_id = vim.bo[buf].channel
  return vim.api.nvim_get_chan_info(chan_id)
end

-- Create a new bat buffer and start terminal with command.
local function create_bat_buffer(cmd)
  vim.cmd("enew")
  vim.api.nvim_buf_set_var(0, "is_bat_buffer", true)
  vim.fn.termopen({ "bash", "-c", cmd })
end

-- Execute function in window, preserving current focus.
local function in_window(win, fn)
  local initial_window = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(win)
  fn()
  vim.api.nvim_set_current_win(initial_window)
end

-- Initialize plugin: merge config and register :Bat command.
function M.setup(opts)
  if opts and opts.enabled then
    local options = config.setup(opts)
    commands.setup(options)
  end
end

-- Get or create the bat terminal window (idempotent).
local function open_window()
  return find_bat_window() or create_bat_window()
end

-- Expose internal functions for testing.
M._find_bat_window = find_bat_window
M._create_bat_window = create_bat_window
M._delete_bat_buffers = delete_bat_buffers
M._get_channel_info = get_channel_info
M._open_window = open_window
M._create_bat_buffer = create_bat_buffer
M._in_window = in_window

-- Load command definitions from JSON file.
-- Returns a table mapping command names to shell command strings.
function M.parse_json(filepath)
  local fullpath = vim.fn.expand(filepath)
  local content = table.concat(vim.fn.readfile(fullpath), "\n")
  local cmds = vim.fn.json_decode(content)
  return cmds
end


-- Execute shell command in the bat terminal window.
-- Returns channel info for the terminal process.
function M.run(cmd)
  delete_bat_buffers()
  local bat_window = open_window()
  in_window(bat_window, function()
    create_bat_buffer(cmd)
  end)
  return get_channel_info(bat_window)
end

return M
