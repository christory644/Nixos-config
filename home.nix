{ config, pkgs, inputs, username, ... }:

let
  inherit (import ./options.nix)
    gitUsername
    gitEmail
    flakeDir
    username
    userHome;
in {
  # home manager settings
  home.username = "${username}";
  home.homeDirectory = "${userHome}";
  home.stateVersion = "23.11";

  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./config/home
  ];

  home.persistence."/persisted/home" = {
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Projects"
      "Videos"
      "VirtualBox VMs"
      ".gnupg"
      ".config/discord"
      ".local/share/direnv"
      ".local/share/keyrings"
      ".local/share/kwalletd"
      ".local/share/systemsettings"
      ".ssh"
#      {
#        directory = "./local/share/Steam";
#	method = "symlink";
#      }
    ];
#    files = [
#      ".screenrc"
#    ];
    allowOther = true;
  };

  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # create XDG directories
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  programs.home-manager.enable = true;
}

