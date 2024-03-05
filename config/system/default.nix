{ config, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./desktopEnvironment.nix
    ./disk.nix
    ./displayManager.nix
    ./microsoftSurface.nix
    ./packages.nix
    ./persistence.nix
    ./services.nix
  ];
}

