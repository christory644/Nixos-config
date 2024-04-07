{ pkgs, config, lib, username, ... }:

let inherit (import ../../options.nix) enableFlatpak; in
lib.mkIf (enableFlatpak == true) {
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-kde
  ];

  environment.persistence."/persisted/system" = {
    directories = [
      "/var/lib/flatpak"
    ];
  };

  home-manager.users.${username} = {
    home.persistence."/persisted/home" = {
      directories = [
        ".cache/flatpak"
        ".local/share/flatpak"
	".var/app"
      ];
    };
  };
}


