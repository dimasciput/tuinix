# Terminal-focused software packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      # Shell and terminal
      fish
    ];
}

