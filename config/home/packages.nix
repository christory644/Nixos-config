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
    obs-studio
    protonup-qt
    spotify
    tree
    youtube-music
  ];

  programs.gh.enable = true;
}

