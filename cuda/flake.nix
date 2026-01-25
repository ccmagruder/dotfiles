# flake.nix
{
  description = "Professional CUDA C++ Project Entry Point";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
  };

  outputs = { self, nixpkgs, claude-code-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # Required for CUDA
        config.cudaSupport = true;
      };
    in {
      # 1. The Package: Allows 'nix build'
      packages.${system}.default = pkgs.callPackage ./default.nix { };

      # 2. The Dev Shell: Allows 'nix develop'
      devShells.${system}.default = pkgs.mkShell {
        # 'inputsFrom' pulls all tools and libs from default.nix!
        # No need to repeat gcc, cmake, or gtest here.
        inputsFrom = [ self.packages.${system}.default ];

        buildInputs = with pkgs; [
          claude-code-nix.packages.${system}.claude-code
          ccls
        ];

        shellHook = ''
          export CUDA_PATH=${pkgs.cudaPackages.cuda_nvcc}
          # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:$LD_LIBRARY_PATH
          export LD_LIBRARY_PATH="/run/opengl-driver/lib:$LD_LIBRARY_PATH"
          echo "🚀 Environment ready. Run 'cmake -B build' to begin."
        '';
      };
    };
}
