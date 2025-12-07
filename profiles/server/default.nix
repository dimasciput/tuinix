# Server profile
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System administration
    htop
    iotop
    nethogs
    iftop
    
    # Network tools
    curl
    wget
    rsync
    
    # Log analysis
    logrotate
    
    # Text processing
    gnugrep
    gnused
    gawk
    
    # File management
    tree
    fd
    ripgrep
    
    # Archive tools
    zip
    unzip
    p7zip
    
    # Security tools
    fail2ban
    
    # Monitoring
    prometheus-node-exporter
    
    # Terminal multiplexer
    tmux
    screen
  ];
  
  # Server services
  services = {
    # SSH server
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        X11Forwarding = false;
      };
    };
    
    # Fail2ban for security
    fail2ban = {
      enable = true;
      maxretry = 3;
      bantime = "1h";
    };
    
    # Log rotation
    logrotate = {
      enable = true;
    };
    
    # Time synchronization
    timesyncd.enable = lib.mkDefault true;
    
    # Firewall
    # (configured through security modules)
  };
  
  # Security hardening
  boot.kernel.sysctl = {
    # Network security
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.accept_source_route" = false;
    "net.ipv4.conf.default.accept_source_route" = false;
    "net.ipv4.icmp_ignore_bogus_error_responses" = true;
    "net.ipv4.tcp_syncookies" = true;
    
    # Process security
    "kernel.dmesg_restrict" = true;
    "kernel.kptr_restrict" = 2;
  };
  
  # System settings
  boot = {
    # Clean /tmp on boot
    tmp.cleanOnBoot = true;
    
    # Kernel hardening
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };
}