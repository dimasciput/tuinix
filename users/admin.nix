# Administrative user definition
{ config, lib, pkgs, ... }:

{
  # Administrative user account
  users.users.admin = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = [ "wheel" "systemd-journal" "docker" ];
    shell = pkgs.zsh;

    # Home directory
    home = "/home/admin";
    createHome = true;

    # SSH authorized keys
    openssh.authorizedKeys.keys = [
      # Add administrative SSH keys here
      # Example: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5... admin@hostname"
    ];

    # Password authentication disabled by default
    # Use SSH keys for authentication
  };

  # Enable home-manager for admin user
  home-manager.users.admin = { pkgs, ... }: {
    # Admin-specific packages
    home.packages = with pkgs; [
      # System administration
      htop
      iotop
      nethogs

      # Security tools
      nmap
      tcpdump

      # Network tools
      curl
      wget
      rsync

      # Development tools
      git
      vim

      # Archive tools
      zip
      unzip
      p7zip
    ];

    # Shell configuration
    programs = {
      # Zsh configuration for admin
      zsh = {
        enable = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;

        oh-my-zsh = {
          enable = true;
          theme = "agnoster";
          plugins = [ "git" "sudo" "systemd" "docker" ];
        };
      };

      # Git configuration
      git = {
        enable = true;
        userName = "Administrator";
        userEmail = "admin@localhost";
      };

      # Tmux configuration
      tmux = {
        enable = true;
        clock24 = true;
        keyMode = "vi";
      };
    };

    # Home Manager state version
    home.stateVersion = "24.05";
  };
}

