{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix)
  flakeDir
  hostname
  userHome
  userShell;
in lib.mkIf (userShell == "fish") {
  programs.fish = {
    enable = true;
    shellAliases = {
      sv = "sudo nvim";
      flake-rebuild="nh os switch --nom --hostname ${hostname}";
      flake-update="nh os switch --nom --hostname ${hostname} --update";
      gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v="nvim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
      neofetch = "neofetch --ascii \"$(fortune | cowsay -f $(ls /run/current-system/sw/share/cowsay/cows | shuf -n1) -W 60)\"";
    };
  };
}

