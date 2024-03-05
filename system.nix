{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./config/system
  ];

  # enable networking
  networking.hostName = "christorySLS";
  networking.networkmanager.enable = true;

  # set system timezone
  time.timeZone = "America/Chicago";

  users = {
    mutableUsers = true;
    users.christory = {
      homeMode = "755";
      initialPassword = "12345";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


  system.stateVersion = "23.11";
}

