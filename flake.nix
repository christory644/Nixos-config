{
  description = "Christory's NixOS Flake";
     
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, disko, impermanence, home-manager, ...} @ inputs:
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        impermanence.nixosModules.impermanence
        home-manager.nixosModules.default
        disko.nixosModules.default
        (import ./disko.nix { device = "/dev/nvme0n1"; })

        ./configuration.nix
              
      ];
    };
  };
}
