{ config, pkgs, ... }:

let inherit (import ../../options.nix)
  flakeDir
  hostname
  userHome;
in {
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "done";
	inherit (pkgs.fishPlugins.done) src;
      }
      #colored-man-pages
      #done
      #fzf
      #pisces
      #puffer
      #sponge
      #z
    ];
    shellAliases = {
      sv = "sudo nvim";
      flake-rebuild="nh os switch --specialisation ${hostname}-$SPECIALIZATION --hostname ${hostname} $FLAKE";
      flake-update="nh os switch --specialisation ${hostname}-$SPECIALIZATION --hostname ${hostname} --update $FLAKE";
      gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v="nvim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
      neofetch = "neofetch --ascii \"$(fortune | cowsay -f tux -W 60)\"";
    };
    shellInitLast = ''
      starship init fish | source
    '';
  };
}

