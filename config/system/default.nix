{ config, pkgs, ... }:

{
  imports = [
    ./appimage.nix
    ./autorotation.nix
    ./bluetooth.nix
    ./boot.nix
    ./flatpak.nix
    ./gpu/intelNvidia.nix
    ./logitech.nix
    ./microsoftSurface.nix
    ./ntp.nix
    ./opengl.nix
    ./packages.nix
    ./persistence.nix
    ./plex.nix
    ./printer.nix
    ./services.nix
    ./vm.nix

    # import specializations
    ../specializations
  ];
}

