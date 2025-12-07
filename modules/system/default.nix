# System-level configuration modules
{ lib, ... }:

{
  imports = [ ./boot.nix ./nix-settings.nix ./shell.nix ./zfs.nix ];
}

