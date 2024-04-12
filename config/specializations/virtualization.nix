{ pkgs, config, ... }:
let inherit (import ../../options.nix) hostname systemCpuType username vfioIds;
in {
  specialisation = {
    "${hostname}-gpuPassThroughVirt".configuration = {
      system.nixos.tags = [ "gpuPassThroughVirt" ];

      # configure kernel options to ensure IOMMU and KVM support is on.
      boot = {
        kernelModules = [ "kvm-${systemCpuType}" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
        kernelParams = [ "${systemCpuType}_iommu=on" "${systemCpuType}_iommu=pt" "kvm.ignore_msrs=1" ];
        extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}";
      };

      # add a file for looking-glass to use, this allows for a performant guest VM screen experience
      systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 ${username} qemu-libvirtd -"
      ];

      # add virt-manager and looking-glass
      environment.systemPackages = with pkgs; [
        virt-manager
	looking-glass-client
      ];

      # enable virtualization 
      virtualisation = {
        libvirtd = {
	  enable = true;
	  extraConfig = ''
	    user="${username}"
	  '';

	  # do not start VM's automatically on boot
	  onBoot = "ignore";

	  # shutdown running VM's on system shutdown
	  onShutdown = "shutdown";

	  qemu = {
	    package = pkgs.qemu_kvm;
	    swtpm.enable = true;
	    ovmf = {
	      enable = true;
	      packages = [ pkgs.OVMFFull.fd ];
	    };
	    verbatimConfig = ''
	      namespaces = []
	      user = "+${builtins.toString config.users.users.${username}.uid}"
	    '';
	  };
	};
      };

      users.users.${username}.extraGroups = [ "qemu-libvirtd" "libvirtd" "disk" ];
    };
  };
}

