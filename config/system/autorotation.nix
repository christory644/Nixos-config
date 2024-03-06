{ config, lib, ... }:

let inherit (import ../../options.nix) enableAutorotationSupport;
in lib.mkIf (enableAutorotationSupport == true) {
  hardware.sensor.iio.enable = true;
}
