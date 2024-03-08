{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
  };
}

