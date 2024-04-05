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
    libnotify
    libvirt
    lm_sensors
    lolcat
    lsd
    lshw
    material-icons
    neofetch
    neovim
    networkmanagerapplet
    nh
    noto-fonts-color-emoji
    playerctl
    polkit_gnome
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
    ydotool
  ];

  programs = {
    # this is maybe not needed, but it's mentioned in the impermenance docs, so here it is
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    # add this back once plasma is fully removed
    #seahorse.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
}

