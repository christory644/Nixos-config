{ config, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir username wallpaperDir wallpaperGit;
in {
  home.packages = with pkgs; [
    asciiquarium
    audacity
    cmatrix
    discord
    firefox
    font-awesome
    neovide
    obs-studio
    spotify
    tree
    youtube-music
    # custom scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/listHyprBindings.nix { inherit pkgs; })
    (import ./../scripts/rofiLauncher.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
    (import ./../scripts/taskWaybar.nix { inherit pkgs; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/themeSelector.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir; inherit username; inherit wallpaperGit;})
    (import ./../scripts/webSearch.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}

