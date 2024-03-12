{ config, pkgs, ... }:

{
  imports = [
    ./appimage.nix
    ./autorotation.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktopEnvironment.nix
    ./displayManager.nix
    ./flatpak.nix
    ./gpu/intelNvidia.nix
    #./hyprlnd.nix
    ./logitech.nix
    ./microsoftSurface.nix
    ./ntp.nix
    ./opengl.nix
    ./packages.nix
    ./persistence.nix
    ./printer.nix
    ./services.nix
    ./vm.nix
  ];
}

