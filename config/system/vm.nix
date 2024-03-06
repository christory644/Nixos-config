{ pkgs, config, lib, ... }:

let inherit (import ../../options.nix) systemCpuType; in
lib.mkIf ("${systemCpuType}" == "vm") {
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
}


