{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.sessionVariables = {
#    XDG_DATA_HOME="$HOME/.local/share";
  };

  environment.systemPackages = with pkgs; [
    steam-run
    protonup-qt
  ];
}

