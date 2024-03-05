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

  outputs = inputs@{nixpkgs, disko, impermanence, home-manager, ...}:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
	inherit system;
      };
      modules = [
        impermanence.nixosModules.impermanence
        disko.nixosModules.default

	./system.nix
        ./configuration.nix

	home-manager.nixosModules.home-manager {
	  home-manager.extraSpecialArgs = { inherit inputs; };
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "backup";
	  home-manager.users.christory = import ./home.nix;
	}
      ];
    };
  };
}
