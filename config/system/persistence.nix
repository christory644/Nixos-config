{
  environment.persistence."/persisted/system" = {
    hideMounts = true;
    directories = [
      "/etc/cups"
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}

