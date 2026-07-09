{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./claude.nix
    ./git.nix
    ./home-manager.nix
    ./nixvim
    ./tmux.nix
    ./zsh.nix
  ];
}
