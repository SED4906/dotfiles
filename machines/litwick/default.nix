{ config, lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  networking.hostName = "litwick";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  services.xserver.enable = true;
  services.xserver.desktopManager.deepin.enable = true;
  services.printing.enable = true;
  services.libinput.enable = true;

  users.users.rba = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };

  programs.firefox.enable = true;

  system.stateVersion = "24.05";
}
