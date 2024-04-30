{ config, gtkThemeFromScheme, pkgs, inputs, username, ... }:

let
  inherit (import ./options.nix)
    gitUsername
    gitEmail
    flakeDir
    theme
    username
    userHome;
in {
  # home manager settings
  home.username = "${username}";
  home.homeDirectory = "${userHome}";
  home.stateVersion = "23.11";

  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  imports = [
    inputs.nix-colors.homeManagerModules.default
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
      ".config/chromium"
      ".config/discord"
      ".config/spotify"
      ".config/YouTube Music"
      ".local/share/applications"
      ".local/share/direnv"
      ".local/share/keyrings"
      ".local/share/systemsettings"
      ".mozilla"
      ".ssh"
    ];
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

