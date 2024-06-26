{ lib, config, pkgs, ... }:
{
  # declare a DE for non specialized boots
  config = lib.mkIf (config.specialisation != {}) {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };

  # import configured specializations
  imports = [
    ./cosmic.nix
    ./hyprland.nix
#    ./virtualization.nix
  ];
}

