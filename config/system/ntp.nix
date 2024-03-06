{ config, lib, options, ... }:

let inherit (import ../../options.nix) enableNTP; in
lib.mkIf (enableNTP == true) {
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
}

