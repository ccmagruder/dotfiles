local M = {}

local config = require("bat.config")
local commands = require("bat.commands")

function M.setup(opts)
  config.setup(opts)
  commands.setup()
end

return M
