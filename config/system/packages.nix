{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
    wget
    discord
    firefox
  ];
}

