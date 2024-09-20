{ config, lib, pkgs, ... }:
let
  user-packages = with pkgs; [
    thunderbird
    libreoffice
    discord
  ];
in
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  networking.hostName = "nacli";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.libinput.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.operation = "boot";

  users.users.tba = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = user-packages;
  };

  users.users.rba = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = user-packages;
  };
  
  programs.firefox.enable = true;

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
