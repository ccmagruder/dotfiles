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
      # ccls.enable = true;
      clangd = {
        enable = true;
        cmd = [
          "clangd"
          "--background-index" # index project in background for faster symbol lookup
          "--clang-tidy" # enable clang-tidy diagnostics inline
          "--pch-storage=memory"
        ];
      };
    };
    keymaps = {
      lspBuf = {
        "gd" = "definition";
        "gD" = "declaration";
        "<leader>ca" = "code_action"; # Useful for ni'ls refactoring
        "<leader>rn" = "rename";
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>j";
      action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
      options.desc = "Next diagnostic";
    }
    {
      mode = "n";
      key = "<leader>k";
      action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
      options.desc = "Prev diagnostic";
    }
  ];
}
