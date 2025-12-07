# Terminal environment configuration
{ config, lib, pkgs, ... }:

with lib;

{
  options.nixmywindows.terminal = {
    enable = mkEnableOption "Enable enhanced terminal environment";
  };

  config = mkIf config.nixmywindows.terminal.enable {
    # Terminal-focused packages
    environment.systemPackages = with pkgs; [
      # Shell and terminal
      zsh
      tmux
      screen
      
      # Text editors
      vim
      neovim
      emacs-nox
      
      # File management
      ranger
      nnn
      lf
      tree
      
      # Network tools
      curl
      wget
      rsync
      
      # System monitoring
      htop
      btop
      iotop
      nethogs
      
      # Development tools
      git
      gnumake
      gcc
      
      # Compression tools
      zip
      unzip
      p7zip
      
      # System utilities
      fd
      ripgrep
      fzf
      bat
      eza
      jq
    ];

    # Default shell configuration
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    
    # Terminal multiplexer
    programs.tmux = {
      enable = true;
      clock24 = true;
    };
  };
}