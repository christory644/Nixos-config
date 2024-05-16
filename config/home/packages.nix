{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    asciiquarium
    audacity
    cava
    chromium
    cmatrix
    discord
    firefox
    font-awesome
    libvirt
    neovide
    obs-studio
    slack
    spotify
    tree
    youtube-music
  ];

  programs.gh.enable = true;
}

