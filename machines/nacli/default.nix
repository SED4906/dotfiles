{ config, lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  networking.hostName = "nacli";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.libinput.enable = true;
  services.autoUpgrade.enable = true;
  services.autoUpgrade.operation = "boot";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;

  users.users.tba = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      thunderbird
      libreoffice
      discord
    ];
  };

  users.users.rba = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      thunderbird
      libreoffice
      discord
    ];
  };

  environment.systemPackages = with pkgs; [
    corefonts
    libimobiledevice
    ifuse
    pavucontrol
    xfce.xfce4-pulseaudio-plugin
    xarchiver
  ];

  system.stateVersion = "23.11";
}
