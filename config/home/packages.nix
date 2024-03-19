{ config, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir username;
in {
  home.packages = with pkgs; [
    asciiquarium
    audacity
    cmatrix
    discord
    firefox
    font-awesome
    neovide
    obs-studio
    spotify
    tree
  ];

  programs.gh.enable = true;
}

