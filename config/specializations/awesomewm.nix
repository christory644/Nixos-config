{ pkgs, lib, config, username, hostname, ... }:
{
  specialisation = {
    "${hostname}-awesome".configuration = {
      system.nixos.tags = [ "awesome" ];
      services.xserver = {
        enable = true;

	displayManager = {
	  sddm.enable = true;
	  defaultSession = "none+awesome";
	};

	windowManager.awesome = {
	  enable = true;
	  luaModules = with pkgs.luaPackages; [
	    luarocks
	  ];
	};
      };

      environment.sessionVariables = {
  	SPECIALIZATION = "awesome";
      };
    };
  };
}

