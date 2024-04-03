{ config, pkgs, hostname, username, ... }:
{
  specialisation = {
    "${hostname}-plasma".configuration = {
      system.nixos.tags = [ "plasma6" ];
      services.xserver = {
        enable = true;
	desktopManager = {
	  plasma6.enable = true;
	};
	displayManager = {
	  sddm.enable = true;
	  sddm.wayland.enable = true;
	};
      };

      home-manager.users.${username} = {
        home.persistence."/persisted/home".directories = [
          ".local/share/kwalletd"
        ];
      };
    };
  };
}

