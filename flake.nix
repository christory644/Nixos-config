{
  description = "Christory's NixOS Flake";
     
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{nixpkgs, nixos-hardware, disko, impermanence, home-manager, ...}:
  let
    system = "x86_64-linux";
    inherit (import ./options.nix) username hostname;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit hostname;
        inherit inputs;
	inherit system;
	inherit username;
      };
      modules = [
	nixos-hardware.nixosModules.microsoft-surface-common
        impermanence.nixosModules.impermanence
        disko.nixosModules.default

	./system.nix

	home-manager.nixosModules.home-manager {
	  home-manager.extraSpecialArgs = { inherit inputs; };
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "backup";
	  home-manager.users.${username} = import ./home.nix;
	}
      ];
    };
  };
}
