{ ... }:
{
  programs.nixvim.plugins.lsp.onAttach = ''
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
  '';

  programs.nixvim.plugins.navic = {
    enable = true;
    settings = {
      separator = " ❯ ";
    };
  };
}
