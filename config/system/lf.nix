{ config, pkgs, ... }:

{
  xdg.configFile."lf/icons".source = ./icons;
  programs.lf = {
    enable = true;

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
	  printf "Directory Name: "
	  read DIR
	  mkdir $DIR
	}}
      '';
    };

    keybindings = {
      "." = "set hidden!";
      "<enter>" = "open";
      
      do = "dragon-out";
    };
    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
  };
}

