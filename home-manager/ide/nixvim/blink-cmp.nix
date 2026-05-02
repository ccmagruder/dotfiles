{ ... }:
{
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        "<C-n>" = [ "select_next" "fallback" ];
        "<C-p>" = [ "select_prev" "fallback" ];
        "<C-y>" = [ "accept" ];
        "<C-Space>" = [ "show" "show_documentation" "hide_documentation" ];
        "<C-e>" = [ "hide" "cancel" ];
      };
      sources.default = [ "lsp" "path" "buffer" ];
    };
  };
}
