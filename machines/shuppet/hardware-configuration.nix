{ config, lib, pkgs, modulesPath, ... }:
{
  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/60a924d9-da66-447a-8f72-ffbc13de6fae";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-b9b7c703-afdb-47a5-8d61-3871590ac44c".device = "/dev/disk/by-uuid/b9b7c703-afdb-47a5-8d61-3871590ac44c";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1092-3262";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/62fd0ba6-0e8a-4262-bdb8-a5e5d29bcf10"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
