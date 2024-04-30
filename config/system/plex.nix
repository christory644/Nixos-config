{ username, ... }:
{
  services.plex = {
    enable = true;
    openFirewall = true;
    user = "${username}";
    dataDir = "/srv/plex";
  };

  services.tautulli.enable = true;

  home-manager.users.${username} = {
    home.persistence."/persisted/home".directories = [
      { 
        directory = "/srv/plex";
	method = "symlink";
      }
    ];
  };
}

