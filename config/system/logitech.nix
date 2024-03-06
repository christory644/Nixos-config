{ config, lib, ... }:

let inherit (import ../../options.nix) enableLogitechSupport;
in lib.mkIf (enableLogitechSupport == true) {
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
}

