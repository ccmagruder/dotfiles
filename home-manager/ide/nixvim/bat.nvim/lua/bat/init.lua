local M = {}

local config = require("bat.config")
local commands = require("bat.commands")

function M.setup(opts)
  if opts and opts.enabled then
    local options = config.setup(opts)
    commands.setup()
  end
end

function M.read_json_config(filepath)
  local fullpath = vim.fn.expand(filepath)
  local content = table.concat(vim.fn.readfile(fullpath), "\n")
  M.data = vim.fn.json_decode(content)
end

return M
