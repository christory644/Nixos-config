{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./disk.nix
    ./persistence.nix
  ];
}

