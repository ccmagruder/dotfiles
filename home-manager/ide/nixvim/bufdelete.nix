{ ... }:
{
  programs.nixvim.plugins.bufdelete.enable = true;
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>Bdelete<cr>";
      options.desc = "Delete buffer, keep window";
    }
  ];
}
