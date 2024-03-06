{ config, lib, ... }:

let inherit (import ../../options.nix) enableBluetoothSupport; 
in lib.mkIf (enableBluetoothSupport == true) {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}

