# ISO image configuration for installation media
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    (modulesPath + "/installer/cd-dvd/channel.nix")
  ];

  # Disable ZFS for ISO images (causes build issues)
  nixmywindows.zfs.enable = lib.mkForce false;
  
  # Override filesystem configuration for ISO
  fileSystems = lib.mkForce { };
  swapDevices = lib.mkForce [ ];
  
  # Basic ISO configuration
  isoImage = {
    # ISO metadata
    isoName = lib.mkForce "${config.nixmywindows.hostname}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";
    
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
          
          This is a nixmywindows installation ISO image.
          
          To install:
          1. Boot from this ISO
          2. Run 'sudo -i' to become root
          3. Partition your disk
          4. Mount your filesystems
          5. Generate hardware config: nixos-generate-config --root /mnt
          6. Copy nixmywindows configuration to /mnt/etc/nixos/
          7. Install: nixos-install --flake /mnt/etc/nixos#${config.nixmywindows.hostname}
          
          For more information, visit:
          https://github.com/timlinux/nixmywindows
        '';
        target = "/README.txt";
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
  
  # Disable custom nixmywindows modules that might conflict with installer
  nixmywindows = {
    security.firewall.enable = lib.mkForce false;
    networking = {
      ethernet.enable = lib.mkForce false;
      wireless.enable = lib.mkForce false;
    };
  };

  # System configuration
  system.stateVersion = "24.05";
}