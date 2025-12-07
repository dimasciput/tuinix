# Workstation profile (terminal-only)
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal productivity
    tmux
    screen
    zsh
    fish
    
    # Text editors
    vim
    neovim
    emacs-nox
    micro
    
    # File management
    ranger
    nnn
    lf
    tree
    fd
    ripgrep
    
    # Media tools (terminal-based)
    mpv
    ffmpeg
    imagemagick
    
    # Network tools
    curl
    wget
    rsync
    
    # System monitoring
    htop
    btop
    iotop
    nethogs
    
    # Development tools (basic)
    git
    python3
    nodejs
    
    # Terminal utilities
    bat
    eza
    fzf
    jq
    
    # Archive tools
    zip
    unzip
    p7zip
    
    # Password management
    pass
    
    # Encryption tools
    gnupg
    
    # Calendar and contacts (terminal-based)
    calcurse
    
    # Email (terminal-based)
    mutt
    
    # Web browsing (terminal-based)
    lynx
    w3m
    
    # Document processing
    pandoc
    
    # Backup tools
    borgbackup
    restic
  ];
  
  # Services for workstation
  services = {
    # SSH client/server
    openssh.enable = true;
    
    # Time synchronization
    timesyncd.enable = lib.mkDefault true;
    
    # Printing (minimal, terminal-focused)
    printing.enable = false;
    
    # Audio (minimal for terminal apps)
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
    };
  };
  
  # Programs
  programs = {
    # Git configuration
    git.enable = true;
    
    # Shell configuration
    zsh.enable = true;
    fish.enable = true;
    
    # GPG agent
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  
  # Security settings appropriate for workstation
  security = {
    # Polkit for user actions
    polkit.enable = true;
    
    # RTKit for audio
    rtkit.enable = true;
  };
  
  # Hardware settings
  hardware = {
    # Audio
    pulseaudio.enable = false; # Using pipewire instead
    
    # Bluetooth (minimal support)
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
}