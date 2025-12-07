{ config, lib, pkgs, inputs, hostname, ... }:

{
  imports = [
    ./hardware.nix
    ../../users/user.nix
  ];

  networking.hostName = hostname;
  system.stateVersion = "24.05";
}

