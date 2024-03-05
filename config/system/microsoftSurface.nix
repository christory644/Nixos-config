{ pkgs, config, ... }:

{
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


