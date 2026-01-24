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
    };
    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
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
