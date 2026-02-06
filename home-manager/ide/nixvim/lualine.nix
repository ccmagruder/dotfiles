{ ... }:
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        disabled_filetypes = {
          statusline = [ "NvimTree" ];
          winbar = [ "NvimTree" ];
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ ];
        lualine_c = [
        ];
        lualine_x = [ "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      tabline = {
        lualine_a = [
          {
            __unkeyed-1 = "buffers";
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "|";
              right = "|";
            };
          }
        ];
        lualine_b = [ ];
        lualine_c = [ ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ "branch" ];
      };
      winbar = {
        lualine_a = [
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 1;
          }
        ];
        lualine_b = [ ];
        lualine_c = [ ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ ];
      };
      inactive_winbar = {
        lualine_a = [ ];
        lualine_b = [
          {
            __unkeyed-1 = "filename";
            path = 1;
          }
        ];
        lualine_c = [ ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ ];
      };
    };
  };
}
