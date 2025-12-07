# SSH configuration
{ config, lib, ... }:

with lib;

{
  options.nixmywindows.security.ssh = {
    enable = mkEnableOption "Enable SSH server";
    
    port = mkOption {
      type = types.int;
      default = 22;
      description = "SSH port";
    };
    
    permitRootLogin = mkOption {
      type = types.enum [ "yes" "no" "prohibit-password" ];
      default = "prohibit-password";
      description = "Permit root login";
    };
    
    passwordAuthentication = mkOption {
      type = types.bool;
      default = false;
      description = "Allow password authentication";
    };
  };

  config = mkIf config.nixmywindows.security.ssh.enable {
    services.openssh = {
      enable = true;
      ports = [ config.nixmywindows.security.ssh.port ];
      
      settings = {
        PermitRootLogin = config.nixmywindows.security.ssh.permitRootLogin;
        PasswordAuthentication = config.nixmywindows.security.ssh.passwordAuthentication;
        
        # Security hardening
        Protocol = 2;
        X11Forwarding = false;
        AllowAgentForwarding = false;
        AllowTcpForwarding = false;
        GatewayPorts = "no";
      };
    };
    
    # Add SSH port to firewall if enabled
    nixmywindows.security.firewall.allowedTCPPorts = 
      mkIf config.nixmywindows.security.firewall.enable 
        [ config.nixmywindows.security.ssh.port ];
  };
}