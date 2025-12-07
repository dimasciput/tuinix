# Ethernet networking configuration
{ config, lib, ... }:

with lib;

{
  options.nixmywindows.networking.ethernet = {
    enable = mkEnableOption "Enable ethernet networking";
    
    useDHCP = mkOption {
      type = types.bool;
      default = true;
      description = "Use DHCP for ethernet interfaces";
    };
  };

  config = mkIf config.nixmywindows.networking.ethernet.enable {
    # Enable networking
    networking = {
      # Use DHCP by default
      useDHCP = lib.mkDefault config.nixmywindows.networking.ethernet.useDHCP;
      
      # Enable systemd-networkd for network management
      useNetworkd = lib.mkDefault true;
      
      # DNS configuration
      nameservers = [ "1.1.1.1" "8.8.8.8" ];
    };
  };
}