# Administrative user definition
{ config, lib, pkgs, ... }:

{
  # Administrative user account
  users.users.admin = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = [ "wheel" "systemd-journal" "docker" ];
    shell = pkgs.fish;

    # Home directory
    home = "/home/admin";
    createHome = true;

    # SSH authorized keys
    openssh.authorizedKeys.keys = [
      # Add administrative SSH keys here
      # Example: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5... admin@hostname"
    ];
    initialPassword = "admin";
  };

  # Enable home-manager for admin user
  home-manager.users.admin = { pkgs, ... }: {
    # Admin-specific packages
    home.packages = with pkgs; [ ];

    # Shell configuration
    programs = {
      # Fish configuration for admin
      fish = {
        enable = true;
        plugins = [{
          name = "fzf-fish";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
            sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
          };
        }];
      };

    };

    # Home Manager state version
    home.stateVersion = "24.05";
  };
}

