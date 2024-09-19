{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;

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

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

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
  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.rba = {
    isNormalUser = true;
    description = "SED";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      discord
      git
    ];
  };

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    maliit-keyboard
    tpm2-tss
    wineWowPackages.waylandFull
  ];

  system.stateVersion = "24.05";
}
