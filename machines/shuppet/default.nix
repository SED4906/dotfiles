{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-89cf1819-f05e-443a-9e91-5721fc852479".device = "/dev/disk/by-uuid/89cf1819-f05e-443a-9e91-5721fc852479";
  boot.initrd.systemd.enable = true;
  boot.binfmt.emulatedSystems = [ "x86_64-windows" ];
  boot.binfmt.registrations.x86_64-windows.interpreter = "${pkgs.wineWowPackages.waylandFull}/bin/wine";
  # Disable camera module, should fix audio (camera didn't work anyways)
  boot.blacklistedKernelModules = [ "ipu3_imgu" ];

  networking.hostName = "shuppet";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";

  services.xserver.enable = false;
  services.onedrive.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [ pkgs.kdePackages.elisa pkgs.kdePackages.kate ];
  services.printing.enable = true;

  users.users.rba = {
    isNormalUser = true;
    description = "SED";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vscode-fhs
      thunderbird
      discord
      git
      cargo
      rustc
      libreoffice
      tenacity
      vlc
    ];
  };

  programs.firefox.enable = true;
  programs.java.enable = true;
  environment.systemPackages = with pkgs; [
    maliit-keyboard
    tpm2-tss
    wineWowPackages.waylandFull
  ];

  system.stateVersion = "24.05";
}
