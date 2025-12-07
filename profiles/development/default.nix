# Development profile
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development tools
    git
    git-lfs
    gh
    
    # Text editors
    vim
    neovim
    emacs-nox
    
    # Version control
    mercurial
    subversion
    
    # Build tools
    gnumake
    cmake
    meson
    ninja
    
    # Compilers and interpreters
    gcc
    clang
    python3
    nodejs
    rustc
    cargo
    go
    
    # Debugging tools
    gdb
    lldb
    valgrind
    strace
    
    # Package managers
    nix-index
    nix-tree
    nix-diff
    
    # Documentation tools
    man-pages
    man-pages-posix
    
    # Network tools for development
    curl
    wget
    httpie
    
    # JSON/YAML tools
    jq
    yq
    
    # Container tools
    docker
    docker-compose
    
    # Performance monitoring
    htop
    iotop
    nethogs
    
    # Shell utilities
    tmux
    screen
    fish
    
    # File management
    ranger
    nnn
    tree
    fd
    ripgrep
    
    # Archive tools
    zip
    unzip
    p7zip
    gnutar
    
    # Terminal utilities
    bat
    eza
    fzf
  ];
  
  # Enable Docker for development
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  
  # Development services
  services = {
    # Enable SSH for remote development
    openssh.enable = lib.mkDefault true;
  };
  
  # Programs
  programs = {
    # Git configuration
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
    
    # Shell configuration
    fish.enable = true;
  };
}