{
  description = "SecureBoot-enabled NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

  outputs = inputs @ { self, nixpkgs, lix-module, nixos-hardware, home-manager, lanzaboote, nix-software-center, ... }:
  let
    commonModules = [
      lix-module.nixosModules.default
      lanzaboote.nixosModules.lanzaboote
      (./common)
    ];
    nixosBox = arch: name: extraModules:
    nixpkgs.lib.nixosSystem {
      system = arch;
      modules = (commonModules) ++ [
        (./. + "/machines/${name}")
        ({inputs, config, pkgs, lib, system, ...}: {
          environment.systemPackages = [
            inputs.nix-software-center.packages.${system}.nix-software-center
          ];
        })
      ] ++ (extraModules);
      specialArgs = { inherit inputs self; system = arch; };
    };
    inariBox = arch: name: extraModules:
    nixpkgs.lib.nixosSystem {
      system = arch;
      modules = (commonModules) ++ [
        (./. + "/machines/${name}")
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.user = import ./inari/home.nix;
        }
      ] ++ (extraModules);
      specialArgs = { inherit inputs self; system = arch; };
    };
  in rec
  {
    nixosConfigurations = {
      shuppet = nixosBox "x86_64-linux" "shuppet" [ nixos-hardware.nixosModules.microsoft-surface-go ];
      nacli = nixosBox "x86_64-linux" "nacli" [ ];
      litwick = inariBox "x86_64-linux" "litwick" [ ];
    };
  };
}
