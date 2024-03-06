{ config, pkgs, ... }:

{
  imports = [
    ./autorotation.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktopEnvironment.nix
    ./disk.nix
    ./displayManager.nix
    ./gpu/intelNvidia.nix
    ./logitech.nix
    ./microsoftSurface.nix
    ./opengl.nix
    ./packages.nix
    ./persistence.nix
    ./printer.nix
    ./services.nix
  ];
}

