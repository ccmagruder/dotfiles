{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./claude.nix
    ./git.nix
    ./github-cli.nix
    ./home-manager.nix
    ./nixvim
    ./tmux.nix
    ./zsh.nix
  ];
}
