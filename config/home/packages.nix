{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    asciiquarium
    audacity
    brave
    cava
    chromium
    cmatrix
    discord
    firefox
    font-awesome
    google-chrome
    libvirt
    neovide
    obs-studio
    spotify
    tree
    youtube-music
  ];

  programs.gh.enable = true;
}

