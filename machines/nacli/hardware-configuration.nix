{ config, lib, pkgs, modulesPath, ... }:
{
  #imports = [ (modulesPath + "installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ehci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/".device = "/dev/disk/by-uuid/f9e1e43d-d5e5-449c-bfc8-a28cc991a606";
  fileSystems."/".fsType = "btrfs";

  fileSystems."/boot".device = "/dev/disk/by-uuid/17B0-4F1F";
  fileSystems."/boot".fsType = "vfat";

  swapDevices.device = "/dev/disk/by-uuid/2d6ccaea-69a9-4a54-9e35-d5fd17032e7e";

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
