# Firewall configuration
{ config, lib, ... }:

with lib;

{
  options.nixmywindows.security.firewall = {
    enable = mkEnableOption "Enable firewall";
    
    allowedTCPPorts = mkOption {
      type = types.listOf types.int;
      default = [];
      description = "List of allowed TCP ports";
    };
    
    allowedUDPPorts = mkOption {
      type = types.listOf types.int;
      default = [];
      description = "List of allowed UDP ports";
    };
  };

  config = mkIf config.nixmywindows.security.firewall.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = config.nixmywindows.security.firewall.allowedTCPPorts;
      allowedUDPPorts = config.nixmywindows.security.firewall.allowedUDPPorts;
      
      # Default deny policy
      rejectPackets = true;
      
      # Disable ping
      allowPing = false;
    };
  };
}