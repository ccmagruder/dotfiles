local M = {}

function M.setup(options)
  vim.api.nvim_create_user_command("Bat", function(opts)
    local arg = opts.args
    cmds = require("bat").read_json_config(options.path)
  end, { nargs = 1 })
end

return M
