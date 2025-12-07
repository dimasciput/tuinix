# Laptop configuration example
{ config, lib, pkgs, inputs, hostname, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware.nix

    # Use laptop-optimized hardware detection (comment out if not available)
    # inputs.nixos-hardware.nixosModules.common-laptop
    # inputs.nixos-hardware.nixosModules.common-laptop-ssd

    # Profiles
    ../../profiles/workstation
    ../../profiles/development

    # Users
    ../../users/admin.nix
    ../../users/user.nix
  ];

  # Enable nixmywindows with laptop-specific settings
  nixmywindows = {
    enable = true;
    hostname = hostname;

    # Terminal environment
    terminal.enable = true;

    # ZFS with encryption
    zfs = {
      enable = true;
      encryption = true;
      autoSnapshot = true;
    };

    # Security
    security = {
      firewall.enable = true;
      ssh = {
        enable = true;
        passwordAuthentication = false;
      };
    };

    # Networking (ethernet only, wireless handled by NetworkManager)
    networking = { ethernet.enable = true; };
  };

  # Laptop-specific hardware
  hardware = {
    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    # Audio
    pulseaudio.enable = false;
  };

  # Power management for laptops
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # TLP for better battery life
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

  # Disable wireless when using NetworkManager
  nixmywindows.networking.wireless.enable = lib.mkForce false;

  # Wireless networking with NetworkManager
  networking.networkmanager.enable = true;

  # Laptop-specific services
  services = {
    # Automatic time synchronization
    timesyncd.enable = lib.mkDefault true;

    # ACPI events
    acpid.enable = true;

    # Thermal management
    thermald.enable = true;

    # Audio
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
    };
  };

  # Environment packages for laptop use
  environment.systemPackages = with pkgs; [
    # Power management
    powertop
    acpi

    # Wireless tools
    iw
    wirelesstools
    wpa_supplicant

    # Bluetooth tools
    bluez
    bluez-tools

    # Audio control (terminal-based)
    alsa-utils
    pulseaudio

    # System monitoring
    lm_sensors

    # Laptop-specific utilities
    brightnessctl
  ];

  # Laptop user configuration
  users.users.user = {
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "bluetooth" ];
  };

  # System state version
  system.stateVersion = "24.05";
}

