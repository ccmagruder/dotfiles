{ config, pkgs, ... }:
{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets."remote/github_token" = { };

  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "ccmagruder";
      user.email = "ccmagruder@gmail.com";
      core.editor = "nvim";
      core.pager = "less -FRX";
      credential.helper = [
        ""
        "!f() { echo \"username=ccmagruder\"; echo \"password=$(cat ${config.sops.secrets."remote/github_token".path})\"; }; f"
      ];
    };
  };
}
