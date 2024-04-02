{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    asciiquarium
    audacity
    cava
    cmatrix
    discord
    firefox
    font-awesome
    libvirt
    neovide
    protonup-qt
    obs-studio
    spotify
    tree
    youtube-music
  ];

  programs.gh.enable = true;
}

