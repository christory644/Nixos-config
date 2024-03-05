{
  # enable the x11 windowing system
  services.xserver.enable = true;
  
  # enable sddm
  services.xserver.displayManager.sddm.enable = true;
}
