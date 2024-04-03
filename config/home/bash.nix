{ config, pkgs, ... }:

let inherit (import ../../options.nix)
  flakeDir
  flakePrev
  flakeBackup
  hostname;
in {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      neofetch
      if [ -f $HOME/.bashrc-personal ]; then
        source $HOME/.bashrc-personal
      fi
    '';
    bashrcExtra = ''
      bind "set completion-ignore-case on"
    '';
    sessionVariables = {
      FLAKE_BACKUP = "${flakeBackup}";
      FLAKE_PREVIOUS = "${flakePrev}";
    };

    shellAliases = {
      sv = "sudo nvim";
      flake-rebuild = "nh os switch --specialisation ${hostname}-$SPECIALIZATION --hostname ${hostname} $FLAKE";
      flake-update = "nh os switch ---specialisation ${hostname}-$SPECIALIZATION --hostname ${hostname} --update $FLAKE";
      nix-gc = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v = "nvim";
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -a";
      lal =  "lsd -al";
      ".." = "cd ..";
      neofetch = "neofetch --ascii \"$(fortune | cowsay -f tux -W 60)\"";
    };
  };
}

