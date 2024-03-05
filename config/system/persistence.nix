{
  # maybe this isn't needed, but it's in the docs
  programs.fuse.userAllowOther = true;

  environment.persistence."/persisted/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}

