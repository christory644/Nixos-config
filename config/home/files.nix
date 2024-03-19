{ config, pkgs, ... }:
{
  home.file.".emoji".source = ./files/emoji;
  home.file.".base16-themes".source = ./files/base16Themes;
  home.file.".config/swaylock-bg.jpg".source = ./files/media/swaylock-bg.jpg;
  home.file.".config/starship.toml".source = ./files/starship.toml;
  home.file.".local/share/fonts" = {
    source = ./files/fonts;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ./files/wlogout;
    recursive = true;
  };
}

