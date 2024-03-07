# set various values that may get used in multiple locations
# so that there is a single source of variadic data for the system
let
  username = "christory";
  hostname = "sls";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/Projects/nixos_conf";
  locale = "en_US.UTF-8";
in {
  # user vars
  username = "${username}";
  hostname = "${hostname}";
  userHome = "${userHome}";
  gitUsername = "Christopher Story";
  gitEmail = "christory@pm.me";
  flakeDir = "${flakeDir}";
  flakePrev = "${userHome}/.nixflake/previous";
  flakeBackup = "${userHome}/.nixflake/backup";
  userShell = "zsh"; # options: bash, zsh

  # system vars
  systemLocale = "${locale}";
  systemLCVars = "${locale}";
  systemKBDLayout = "us";
  systemTimezone = "America/Chicago";
  systemCpuType = "intel"; # options: intel, amd, vm

  # for nvidia hybrid devices, we need these values.
  # see nixos.wiki/wiki/Nvidia for more details
  # including how to find determine values
  intelBusID = "PCI:0:2:0";
  nvidiaBusID = "PCI:243:0:0";

  # system flags, to trigger functionality that may not be needed for all systems
  enablePrinting = true;
  enableNTP = true;
  enableFlatpak = false;
  enableVirtualization = false;
  enableLogitechSupport = true;
  enableAppimageSupport = true;
  enableBluetoothSupport = true;
  enableMicrosoftSurfaceSupport = true;
  enableAutorotationSupport = true;
}

