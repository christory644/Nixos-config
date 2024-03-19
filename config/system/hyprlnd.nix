{ pkgs, inputs, ... }:

{
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  environment.sessionVariables = {
    # stops cursor from becoming invisible, maybe not needed?
    # WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # mount, trash, and other fun functionalities
  services.tumbler.enable = true; # img thumbnail support

  services.gnome.gnome-keyring.enable = true;
  services.blueman.enable = true;
}

