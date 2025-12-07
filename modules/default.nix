# Main modules entry point
{ lib, ... }:

{
  imports = [
    ./nixmywindows
    ./system
    ./security
    ./networking
  ];
}