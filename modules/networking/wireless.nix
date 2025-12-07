# Wireless networking configuration
{ config, lib, pkgs, ... }:

with lib;

{
  options.nixmywindows.networking.wireless = {
    enable = mkEnableOption "Enable wireless networking";
  };

  config = mkIf config.nixmywindows.networking.wireless.enable {
    # Wireless networking
    networking.wireless = {
      enable = true;
      userControlled.enable = true;
    };
    
    # Alternative: NetworkManager (comment out wireless above if using this)
    # networking.networkmanager.enable = true;
    
    # Wireless tools
    environment.systemPackages = with pkgs; [
      wpa_supplicant
      wirelesstools
      iw
    ];
  };
}