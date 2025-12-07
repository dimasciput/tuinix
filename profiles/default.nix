# Default profiles entry point
{ lib, ... }:

{
  imports = [
    ./development
    ./server
    ./workstation
  ];
}