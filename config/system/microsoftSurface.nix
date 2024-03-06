{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) enableMicrosoftSurfaceSupport;
in lib.mkIf (enableMicrosoftSurfaceSupport == true) {
  # Microsoft surface controls
  microsoft-surface = {
    ipts.enable = true;
    surface-control.enable = true;
  };

  environment.systemPackages = with pkgs; [
    linux-firmware
    libwacom-surface
  ];
}


