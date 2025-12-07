# Laptop hardware configuration
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Basic filesystem for laptop
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  # Swap
  swapDevices = [ ];

  # Boot configuration
  boot = {
    initrd = {
      availableKernelModules = [ 
        "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  # Hardware settings
  hardware = {
    # Enable all firmware
    enableAllFirmware = true;
    
    # CPU microcode updates
    cpu.intel.updateMicrocode = true;
  };

  # Power management
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}