{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    asciiquarium
    appimage-run
    btop
    cmatrix
    cowsay
    curl
    discord # move to home manager eventually
    eza
    firefox # move to home manager eventually
    git
    htop
    lm_sensors
    lolcat
    lsd
    lshw
    neofetch
    neovim
    nh
    noto-fonts-color-emoji
    ripgrep
    symbola
    unrar
    unzip
    v4l-utils
    vim
    wget
    wl-clipboard
  ];

  programs = {
    # this is maybe not needed, but it's mentioned in the impermenance docs, so here it is
    fuse.userAllowOther = true;
  };
}

