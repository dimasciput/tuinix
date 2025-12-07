# Boot configuration
{ config, lib, pkgs, ... }:

{
  # Boot loader configuration
  boot = {
    loader = {
      systemd-boot = {
        enable = lib.mkDefault true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = lib.mkDefault true;
      timeout = lib.mkDefault 5;
    };
    
    # Kernel configuration
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    
    # Clean /tmp on boot
    tmp.cleanOnBoot = true;
    
    # Enable Plymouth for boot splash
    plymouth.enable = false; # Keep minimal for terminal-only
  };
}