{ pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "23.11";

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
      {
        directory = "./local/share/Steam";
	method = "symlink";
      }
    ];
    files = [
      ".screenrc"
    ];
    allowOther = true;
  };
}
