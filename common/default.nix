{ config, pkgs, ... }: {
  imports = [
    ./audio.nix
    ./locale.nix
    ./secure-boot.nix
    ./software-center.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
}
