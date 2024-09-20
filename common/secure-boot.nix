{ pkgs, lib, ... }: {
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote.enable = true;
  boot.lanzaboote.pkiBundle = "/etc/secureboot";
  environment.systemPackages = [ pkgs.sbctl ];
}