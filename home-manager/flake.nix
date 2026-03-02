{
  description = "Home Manager configuration of remote";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs@{ flake-parts, nixvim, sops-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [inputs.home-manager.flakeModules.home-manager ];
      systems = [ "aarch64-linux" "x86_64-linux" ];
      flake.homeConfigurations."remote@x86" =
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./home.nix ./ide sops-nix.homeManagerModules.sops ];
          extraSpecialArgs = { inherit inputs; };
        };
      flake.homeConfigurations."remote@arm" =
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";
          modules = [ ./home.nix ./ide sops-nix.homeManagerModules.sops ];
          extraSpecialArgs = { inherit inputs; };
        };
    };
}
