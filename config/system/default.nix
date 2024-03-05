{ config, pkgs, ... }:

{
  imports = [
    ./autorotation.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktopEnvironment.nix
    ./disk.nix
    ./displayManager.nix
    ./gpu
    ./microsoftSurface.nix
    ./opengl.nix
    ./packages.nix
    ./persistence.nix
    ./services.nix
  ];
}

