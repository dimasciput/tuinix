# Core nixmywindows module
{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./terminal-env.nix
    ./zfs.nix
  ];

  options.nixmywindows = {
    enable = mkEnableOption "Enable nixmywindows terminal-only environment";
    
    hostname = mkOption {
      type = types.str;
      description = "System hostname";
    };
  };

  config = mkIf config.nixmywindows.enable {
    # Disable graphical services
    services.xserver.enable = false;
    
    # Essential system packages
    environment.systemPackages = with pkgs; [
      vim
      git
      curl
      wget
      htop
      tmux
      zsh
    ];

    # Set hostname
    networking.hostName = config.nixmywindows.hostname;
    
    # Enable essential services
    services.openssh.enable = true;
    
    # Use systemd-boot
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}