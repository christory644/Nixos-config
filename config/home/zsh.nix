{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix)
  flakeDir
  hostname
  userHome
  userShell;
in lib.mkIf (userShell == "zsh") {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    historySubstringSearch.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" ];
    };

    initExtra = ''
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}'       	# Case insensitive tab completion
      zstyle ':completion:*' menu select
      autoload -Uz compinit && compinit
      bindkey '^[[3~' delete-char                     # Key Del
      bindkey '^[[5~' beginning-of-buffer-or-history  # Key Page Up
      bindkey '^[[6~' end-of-buffer-or-history        # Key Page Down
      bindkey '^[[1;3D' backward-word                 # Key Alt + Left
      bindkey '^[[1;3C' forward-word                  # Key Alt + Right
      bindkey '^[[H' beginning-of-line                # Key Home
      bindkey '^[[F' end-of-line                      # Key End
      neofetch
      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
      eval "$(starship init zsh)"
    '';

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      path = "${userHome}/.config/zsh/history";
      share = false;
      size = 100000;
      save = 100000;
    };

    profileExtra = ''
      setopt correct							# auto correct mistakes
      setopt extendedglob						# extended globbing, allows regex with *
      setopt nocaseglob							# case insensitive globbing
      setopt numericglobsort						# sort filenames numerically when it makes sense
      setopt appendhistory						# immediately append history instead of overwriting
      unsetopt histignorealldups					# if a new command is a duplicate, do not remove the older one from history
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"       	# Colored completion (different colors for dirs/files/etc)
      zstyle ':completion:*' rehash true                              	# automatically find new executables in path
      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      mkdir -p "$(dirname ${userHome}/.config/zsh/history)"
      mkdir -p "$(dirname ${userHome}/.config/zsh/completion-cache)"
      zstyle ':completion:*' cache-path "${userHome}/.config/zsh/completion-cache"
    '';
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

