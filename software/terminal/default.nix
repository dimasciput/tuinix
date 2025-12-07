# Terminal-focused software packages
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shell and terminal
    zsh
    bash
    fish
    tmux
    screen
    
    # Text editors
    vim
    neovim
    emacs-nox
    micro
    nano
    
    # File managers
    ranger
    nnn
    lf
    vifm
    
    # File utilities
    tree
    fd
    ripgrep
    fzf
    bat
    eza
    
    # Text processing
    gnugrep
    gnused
    gawk
    jq
    yq
    
    # Network tools
    curl
    wget
    httpie
    rsync
    
    # System monitoring
    htop
    btop
    iotop
    nethogs
    iftop
    
    # Archive tools
    zip
    unzip
    p7zip
    gnutar
    gzip
    bzip2
    xz
    
    # Media tools (terminal-based)
    mpv
    ffmpeg
    imagemagick
    
    # Document tools
    pandoc
    
    # Web browsing (terminal)
    lynx
    w3m
    
    # Email (terminal)
    mutt
    neomutt
    
    # Calendar
    calcurse
    
    # Password management
    pass
    bitwarden-cli
    
    # Communication
    irssi
    weechat
    
    # Development utilities
    git
    tig
    lazygit
    
    # System utilities
    psmisc
    procps
    util-linux
    coreutils
    findutils
  ];
}