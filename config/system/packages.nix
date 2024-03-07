{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    appimage-run
    btop
    cowsay
    curl
    eza
    fortune
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

