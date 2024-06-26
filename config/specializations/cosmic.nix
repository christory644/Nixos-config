{ pkgs, lib, config, username, hostname, ... }:
{
  specialisation = {
    "${hostname}-cosmic".configuration = {
      system.nixos.tags = [ "cosmic" ];

      nix.settings = {
        substituters = [ "https://cosmic.cachix.org/" ];
	trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
      };

      environment.sessionVariables = {
        SPECIALIZATION = "cosmic";
      };

      services.desktopManager.cosmic.enable = true;
      services.displayManager.cosmic-greeter.enable = true;
    };
  };
}

