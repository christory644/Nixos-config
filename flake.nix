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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
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
	inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
      };
      modules = [
        impermanence.nixosModules.impermanence
        disko.nixosModules.default

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
