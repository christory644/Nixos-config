{ config, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./disk.nix
    ./persistence.nix
  ];
}

