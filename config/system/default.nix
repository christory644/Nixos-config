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
    ./hyprlnd.nix
    ./logitech.nix
    ./microsoftSurface.nix
    ./ntp.nix
    ./opengl.nix
    ./packages.nix
    ./persistence.nix
    ./polkit.nix
    ./printer.nix
    ./services.nix
    ./steam.nix
    ./vm.nix
  ];
}

