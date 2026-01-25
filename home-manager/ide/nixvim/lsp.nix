{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nil_ls.enable = true;
      nixd = {
        enable = true;
        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
          formatting.command = [ "nixfmt" ];
          options = {
            nixos.expr = ''(builtins.getFlake "/etc/nixos").nixosConfigurations.nixos.options'';
          };
        };
      };
      ccls.enable = true;
    };
    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
        "<leader>d" = "open_float";
      };
      lspBuf = {
        "gd" = "definition";
        "K" = "hover";
        "<leader>ca" = "code_action"; # Useful for ni'ls refactoring
        "<leader>rn" = "rename";
      };
    };
  };
}
