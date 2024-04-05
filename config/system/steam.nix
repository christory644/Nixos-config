{ pkgs-stable, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs-stable.steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.sessionVariables = {
    XDG_DATA_HOME="$HOME/.local/share";
  };

  environment.systemPackages = with pkgs-stable; [
    steam-run
    protonup-qt
  ];
}

