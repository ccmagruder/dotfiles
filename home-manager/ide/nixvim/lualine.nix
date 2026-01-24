{ ... }:
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" "diff" "diagnostic" ];
        lualine_c = [ 
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 3;
          }
        ];
        lualine_x = [ "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      tabline = {
        lualine_a = [ "buffers" ];
        lualine_b = [ ];
        lualine_c = [ ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ "branch" ];
      };
    };
  };
}
