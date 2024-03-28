{ config, pkgs, hostname, username, ... }:
{
  specialisation = {
    "${hostname}-plasma".configuration = {
      system.nixos.tags = [ "plasma6" ];
      services.xserver.desktopManager.plasma6.enable = true;
      home-manager.users.${username} = {
        home.persistence."/persisted/home".directories = [
          ".local/share/keyrings"
          ".local/share/kwalletd"
          ".local/share/systemsettings"
        ];
      };
    };
  };
}

