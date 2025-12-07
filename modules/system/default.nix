# System-level configuration modules
{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./locale.nix
    ./nix-settings.nix
  ];
}