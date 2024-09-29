{ config, lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  networking.hostName = "litwick";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "24.05";
}
