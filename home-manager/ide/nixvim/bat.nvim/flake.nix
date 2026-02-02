{
  description = "bat.nvim - Neovim plugin for bat integration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        plenary-nvim = pkgs.vimPlugins.plenary-nvim;

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.neovim
          ];

          shellHook = ''
            export PLENARY_PATH="${plenary-nvim}"
            export BAT_PATH="$PWD"
            export XDG_CONFIG_HOME=""

            echo "Run tests with:"
            echo "nvim --headless -u tests/minimal_init.lua -c 'PlenaryBustedDirectory tests/'"
          '';
        };
      });
}
