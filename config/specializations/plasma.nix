{ config, pkgs, hostname, username, ... }:
{
  specialisation = {
    "${hostname}-plasma".configuration = {
      system.nixos.tags = [ "plasma6" ];
      services.xserver.desktopManager.plasma6.enable = true;
      services.xserver.displayManager.sddm.enable = true;
      services.xserver.displayManager.sddm.wayland.enable = true;
      home-manager.users.${username} = {
        home.persistence."/persisted/home".directories = [
          ".local/share/keyrings"
          ".local/share/kwalletd"
        ];
      };
    };
  };
}

