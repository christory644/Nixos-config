{ inputs, config, pkgs, ... }:

let inherit (import ./options.nix)
  flakeDir
  gitUsername
  hostname
  systemKBDLayout
  systemLCVars
  systemLocale
  systemTimezone
  username
  userShell;
in {
  imports = [
    ./hardware.nix
    ./config/system
  ];

  # enable networking
  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;

  # set system timezone
  time.timeZone = "${systemTimezone}";

  # Select internationalisation properties
  i18n.defaultLocale = "${systemLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${systemLCVars}";
    LC_IDENTIFICATION = "${systemLCVars}";
    LC_MEASUREMENT = "${systemLCVars}";
    LC_MONETARY = "${systemLCVars}";
    LC_NAME = "${systemLCVars}";
    LC_NUMERIC = "${systemLCVars}";
    LC_PAPER = "${systemLCVars}";
    LC_TELEPHONE = "${systemLCVars}";
    LC_TIME = "${systemLCVars}";
  };

  console.keyMap = "${systemKBDLayout}";

  users = {
    mutableUsers = true;
    users.christory = {
      description = "${gitUsername}";
      homeMode = "755";
      # use mkpasswd -m sha-512 newPassword to generate a new hashed pass
      hashedPassword = "$6$KAs3Mz0mY.fpjdWe$45R71AhZVstzAPvdUpMlge.zVTCzhr1Mq6JmthxOON3at2Z8iwf.6UF/dACytbXzJ.2ii84PWWvZJQBlBNLJL1";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.${userShell};
      ignoreShellProgramCheck = true;
    };
  };

  environment.variables = {
    FLAKE = "${flakeDir}";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


  system.stateVersion = "23.11";
}

