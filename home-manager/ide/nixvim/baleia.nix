{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ baleia-nvim ];

    extraConfigLua = ''
      local baleia = require("baleia").setup({ strip_ansi_codes = true, async = false })

      vim.api.nvim_create_autocmd("BufReadPost", {
        group = vim.api.nvim_create_augroup("BaleiaResults", { clear = true }),
        pattern = "*.txt.gz",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.schedule(function()
            vim.bo[buf].readonly = false
            vim.bo[buf].modifiable = true
            baleia.once(buf)
            vim.bo[buf].modified = false
            vim.bo[buf].readonly = true
            vim.bo[buf].modifiable = false
          end)
        end,
      })
    '';
  };
}
