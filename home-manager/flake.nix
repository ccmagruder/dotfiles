{
  description = "Home Manager configuration of remote";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
    bat-nvim.url = "github:ccmagruder/bat.nvim";
  };

  outputs = inputs@{ flake-parts, nixvim, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [inputs.home-manager.flakeModules.home-manager ];
      systems = [ "aarch64-darwin" "x86_64-linux" ];
      flake.homeConfigurations."alien"=
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./home-alien.nix ./ide ];
          extraSpecialArgs = { inherit inputs; };
        };
      flake.homeConfigurations."studio" =
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."aarch64-darwin";
          modules = [ ./home-studio.nix ./ide ];
          extraSpecialArgs = { inherit inputs; };
        };
      flake.homeConfigurations."vector"=
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./home-vector.nix ./ide ];
          extraSpecialArgs = { inherit inputs; };
        };
      flake.homeConfigurations."mbp" =
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."aarch64-darwin";
          modules = [ ./home-mbp.nix ./ide ];
          extraSpecialArgs = { inherit inputs; };
        };
    };
}
