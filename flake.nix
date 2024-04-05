{
  description = "Christory's NixOS Flake";
     
  inputs = {
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
  };

  outputs = inputs@{nixpkgs, nixpkgs-stable, nixos-hardware, disko, impermanence, home-manager, nixos-cosmic, ...}:
  let
    system = "x86_64-linux";
    inherit (import ./options.nix) username hostname;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    pkgs-stable = import nixpkgs-stable {
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
	inherit pkgs-stable;
	inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
      };
      modules = [
        impermanence.nixosModules.impermanence
        disko.nixosModules.default
	nixos-cosmic.nixosModules.default

	./hosts
	./system.nix

	home-manager.nixosModules.home-manager {
	  home-manager.extraSpecialArgs = { 
	    inherit inputs;
	    inherit username;
	    inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
	  };
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "backup";
	  home-manager.users.${username} = import ./home.nix;
	}
      ];
    };
  };
}
