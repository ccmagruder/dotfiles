local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Bat", function()
    print("Hello World!")
  end, {})
end

return M
