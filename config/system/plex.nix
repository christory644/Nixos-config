{ username, ... }:
{
  services.plex = {
    enable = true;
    openFirewall = true;
    user = "${username}";
    dataDir = "/srv/plex";
  };

  environment.persistence."/persisted/system" = {
    hideMounts = true;
    directories = [
      "/srv/plex"
    ];
  };
}

