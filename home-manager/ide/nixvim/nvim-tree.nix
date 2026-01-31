{ ... }:
{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    settings = {
      renderer.indent_markers.enable = true;
      view.signcolumn = "no";
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<CR>";
    }
  ];
}
