# ISO image configuration for installation media
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    (modulesPath + "/installer/cd-dvd/channel.nix")
  ];

  
  # Override filesystem configuration for ISO
  fileSystems = lib.mkForce {
    "/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "mode=0755" ];
    };
  };
  swapDevices = lib.mkForce [ ];
  
  # Basic ISO configuration
  isoImage = {
    # ISO metadata
    isoName = lib.mkForce "nixmywindows-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";
    
    # Compression
    compressImage = true;
    squashfsCompression = "zstd";
    
    # Boot configuration
    makeEfiBootable = true;
    makeUsbBootable = true;
    
    # ISO contents
    contents = [
      {
        source = pkgs.writeText "README" ''
          nixmywindows Installation ISO
          
          This is a nixmywindows installation ISO image with the configuration included.
          
          To install:
          1. Boot from this ISO
          2. Run 'sudo -i' to become root
          3. Partition your disk (or use the included disk configuration)
          4. Mount your filesystems
          5. Install: nixos-install --flake /nixmywindows#${config.networking.hostName}
          
          The nixmywindows configuration is available at /nixmywindows
          
          For more information, visit:
          https://github.com/timlinux/nixmywindows
        '';
        target = "/README.txt";
      }
      {
        source = ./.;
        target = "/nixmywindows";
      }
    ];
  };

  # Installer environment packages
  environment.systemPackages = with pkgs; [
    # Partitioning tools
    parted
    gptfdisk
    
    # File system tools
    e2fsprogs
    dosfstools
    
    # ZFS tools (for manual setup)
    zfs
    
    # Network tools
    curl
    wget
    
    # Text editors
    vim
    nano
    
    # Archive tools
    gnutar
    gzip
    
    # System tools
    htop
    tmux
    
    # Git for cloning configurations
    git
  ];

  # Enable SSH for remote installation
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };
  
  # Set root password for SSH access during installation
  users.users.root.initialHashedPassword = lib.mkForce null;
  users.users.root.password = "nixmywindows";
  
  # Network configuration for installer
  networking = {
    # Use DHCP for network interfaces
    useDHCP = lib.mkForce true;
    
    # Enable NetworkManager for easier wireless setup
    networkmanager.enable = lib.mkForce true;
    
    # Disable our custom networking modules for ISO
    firewall.enable = lib.mkForce false;
  };
  

  # System configuration
  system.stateVersion = "24.05";
}