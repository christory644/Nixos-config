{ config, pkgs, ... }:
let inherit (import ../../options.nix) 
  mainKbdLayout
  kbdVariant
  secondaryKbdLayout;
in {
  services.xserver = {
    enable = true;
    xkb = {
      variant = "${kbdVariant}";
      layout = "${mainKbdLayout}, ${secondaryKbdLayout}";
    };
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "tokyo-night-sddm";
    };
  };

  environment.systemPackages = let
    sugar = pkgs.callPackage ../pkgs/sddm-sugar-dark.nix {};
    tokyo-night = pkgs.libsForQt5.callPackage ../pkgs/sddm-tokyo-night.nix {};
  in [
    sugar.sddm-sugar-dark
    tokyo-night
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];

}
