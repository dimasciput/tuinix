# Simple installer ISO configuration
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  # Include the nixmywindows flake for installation
  isoImage.contents = [
    {
      source = ./.;
      target = "/nixmywindows";
    }
    {
      source = ./README.txt;
      target = "/README.txt";
    }
    {
      source = ./scripts/install.sh;
      target = "/install.sh";
    }
    {
      source = ./templates/disko-template.nix;
      target = "/nixmywindows/templates/disko-template.nix";
    }
  ];

  # Basic packages for installation
  environment.systemPackages = with pkgs; [
    git
    vim
    nano
    curl
    wget
    parted
    gptfdisk
    e2fsprogs
    dosfstools
    zfs
    disko
    gum  # For rich interactive UX in install script
    bc   # For space calculations in install script
  ];

  # Enable SSH
  services.openssh.enable = true;
  
  # Set root password (override any defaults)
  users.users.root = {
    password = "nixos";
    initialHashedPassword = lib.mkForce null;
    hashedPassword = lib.mkForce null;
    hashedPasswordFile = lib.mkForce null;
    initialPassword = lib.mkForce null;
  };

  # Network configuration
  networking.useDHCP = lib.mkForce true;
  networking.networkmanager.enable = lib.mkForce true;
  networking.firewall.enable = lib.mkForce false;

  # Enable flakes and nix-command for disko and nixos-install
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}

