{ config, pkgs, ... }:

{
  imports = [
    ./appimage.nix
    ./autorotation.nix
    ./bluetooth.nix
    ./boot.nix
    ./displayManager.nix
    ./flatpak.nix
    ./gpu/intelNvidia.nix
    ./hyprlnd.nix
    ./jellyfin.nix
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

    # import specializations
    ./../specializations
  ];
}

