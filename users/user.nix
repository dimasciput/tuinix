# Default user user definition
{ config, lib, pkgs, ... }:

{
  # User account for user
  users.users.user = {
    isNormalUser = true;
    description = "user user";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.fish;

    # Home directory
    home = "/home/user";
    createHome = true;

    # SSH authorized keys (to be filled in by host configuration)
    openssh.authorizedKeys.keys = [
      # Add your SSH public keys here
      # Example: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5... user@hostname"
    ];

    # Initial password (change on first login)
    # Use: mkpasswd -m sha-512 to generate a hashed password
    initialPassword = "changeme";
  };

  # Enable home-manager for this user
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.user = { pkgs, ... }: {
      # User packages
      home.packages = with pkgs; [
        # Personal utilities
        direnv
        starship

        # Development tools
        git
        gh

        # Terminal utilities
        fzf
        bat
        eza
        fd
        ripgrep
      ];

      # Shell configuration
      programs = {
        # Fish configuration
        fish = {
          enable = true;
          plugins = [
            {
              name = "fzf-fish";
              src = pkgs.fetchFromGitHub {
                owner = "PatrickF1";
                repo = "fzf.fish";
                rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
                sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
              };
            }
          ];
        };

        # Starship prompt
        starship = {
          enable = true;
          enableFishIntegration = true;
        };

        # Git configuration
        git = {
          enable = true;
          userName = "user";
          userEmail = "user@localhost";

          extraConfig = {
            init.defaultBranch = "main";
            pull.rebase = true;
            push.autoSetupRemote = true;
          };
        };

        # Tmux configuration
        tmux = {
          enable = true;
          clock24 = true;
          keyMode = "vi";
          prefix = "C-a";
        };

        # Neovim configuration
        neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
        };

        # Direnv
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };

      # Home Manager state version
      home.stateVersion = "24.05";
    };
  };
}

