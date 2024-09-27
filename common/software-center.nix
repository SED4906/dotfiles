{inputs, config, pkgs, lib, system, ...}: {
  environment.systemPackages = [
    inputs.nix-software-center.packages.${system}.nix-software-center
  ];
}
