local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Bat", function(opts)
    local arg = opts.args

    require("bat").read_json_config("bat.json")
    print(require("bat").data[arg])
  end, { nargs = 1 })
end

return M
