{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    appimage-run
    bat
    brightnessctl
    btop
    cowsay
    curl
    eza
    fortune
    fzf
    git
    htop
    lm_sensors
    lolcat
    lsd
    lshw
    neofetch
    neovim
    networkmanagerapplet
    nh
    noto-fonts-color-emoji
    ripgrep
    swappy
    symbola
    unrar
    unzip
    v4l-utils
    vim
    wget
    wl-clipboard
    yad
  ];

  programs = {
    # this is maybe not needed, but it's mentioned in the impermenance docs, so here it is
    fuse.userAllowOther = true;
  };
}

