local M = {}

function M.setup(options)
  vim.api.nvim_create_user_command("Bat", function(opts)
    local arg = opts.args

    require("bat").read_json_config(options.path)
    print(require("bat").data[arg])
  end, { nargs = 1 })
end

return M
