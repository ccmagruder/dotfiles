local M = {}

local defaults = {
  enabled = true,
  path = ".bat.json"
}

function M.setup(opts)
  return vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
