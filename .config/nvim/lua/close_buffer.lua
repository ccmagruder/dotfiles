-- Close buffer without closing encapulating window
local function close_buffer()
  local old_buf = vim.api.nvim_get_current_buf()

  if vim.bo[old_buf].buflisted == false then
  -- Corner case: buffer is not listed

    if vim.bo[old_buf].filetype == 'nvim-output' then
      -- Corner case: nvim output buffer, close without switching
      vim.api.nvim_buf_delete(old_buf, {})
      return

    else
      -- Corner case: unlisted buffers (excepting nvim output) don't close
      vim.print("nvim-docker.close_buffer: Not a valid buffer to close.")
      return
    end
  end

  -- Determine the number of open bufs
  local nbufs = 0
  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) == true and vim.bo[buf].buflisted == true then
      nbufs = nbufs + 1
    end
  end

  if nbufs == 1 then
    -- Corner case: create dummy buffer to switch to when closing last buffer
    vim.api.nvim_create_buf(true, false)
  end

  -- Switch to next buffer, close previous
  vim.cmd('bn')
  vim.api.nvim_buf_delete(old_buf, {})
end

return close_buffer

