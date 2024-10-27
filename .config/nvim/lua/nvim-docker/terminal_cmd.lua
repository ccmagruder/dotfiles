local function terminal_cmd(cmd)
  local terminal_cmd_win
  local prev_win = vim.api.nvim_get_current_win()

  -- Search for a window with w:tag variable, assign id to new_win
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.w[win].tag then
      terminal_cmd_win = win
      break
    end
  end
 
  -- If no windows are tagged, create a new one and tag it
  if terminal_cmd_win == nil then
    local bufid = vim.api.nvim_create_buf(false, false)
    vim.bo[bufid].filetype = 'nvim-output'
    vim.cmd("botright vsplit")
    terminal_cmd_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(prev_win)
    vim.api.nvim_win_set_var(terminal_cmd_win, "tag", 1)
  end

  -- Swap with new [unmodified] buffer, delete old buffer
  local old_buf = vim.api.nvim_win_get_buf(terminal_cmd_win)
  local new_buf = vim.api.nvim_create_buf(false, false)
  vim.bo[new_buf].filetype = 'nvim-output'
  vim.api.nvim_win_set_buf(terminal_cmd_win, new_buf)
  if vim.bo[old_buf].filetype == 'nvim-output' then
    vim.api.nvim_buf_delete(old_buf, {})
  end

  -- Temporarily switch to tagged window to run termopen(), switch back
  vim.api.nvim_set_current_win(terminal_cmd_win)
  -- I have not found a method to run termopen on a non-current window,
  -- however; it seems like there should be a way.
  vim.fn.termopen(cmd)
  -- Auto scoll to end of output as printed
  -- https://github.com/ViRu-ThE-ViRuS/configs/blob/f2b001b07b0da4c39b3beea00c90f249906d375c/nvim/lua/lib/misc.lua#L27
  local target_line = vim.tbl_count(vim.api.nvim_buf_get_lines(0, 0, -1, true))
  vim.api.nvim_win_set_cursor(terminal_cmd_win, { target_line, 0 })
  vim.api.nvim_set_current_win(prev_win)
end

return terminal_cmd

