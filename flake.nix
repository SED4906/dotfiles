{
  description = "SecureBoot-enabled NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lix-module, nixos-hardware, lanzaboote, ... }:
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
      ] ++ (extraModules);
    };
  in
  {
    nixosConfigurations = {
      shuppet = nixosBox "x86_64-linux" "shuppet" [ nixos-hardware.nixosModules.microsoft-surface-go ];
      nacli = nixosBox "x86_64-linux" "nacli" [ ];
      litwick = nixosBox "x86_64-linux" "litwick" [ ];
    };
  };
}
