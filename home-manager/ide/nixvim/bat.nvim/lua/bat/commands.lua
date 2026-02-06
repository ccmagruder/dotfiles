local M = {}


function M.setup(options)
  vim.api.nvim_create_user_command("Bat", function(opts)
    local bat = require("bat")
    local arg = opts.args
    cmds = bat.read_json_config(options.path)
    bat.run(cmds[arg])
  end, { nargs = 1 })
end

return M
