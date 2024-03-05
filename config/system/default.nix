{ config, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./disk.nix
    ./packages.nix
    ./persistence.nix
  ];
}

