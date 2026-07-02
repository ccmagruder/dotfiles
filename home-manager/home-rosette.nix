{ config, pkgs, inputs, lib, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "caleb.magruder";
  home.homeDirectory = "/home/caleb.magruder";

  programs.git.settings = {
    user.email = "caleb.magruder@simplerose.com";
  };

  home.packages = [
    inputs.claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Appends PATH with nix commands and installed binaries such as nvim.
  # Since nix on rosette is installed single-user, these commands are not added
  # system-wide in /etc/profile.
  programs.zsh.envExtra = ''
    if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
  '';

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
