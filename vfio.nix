{ config, pkgs, lib, ...}: 
{
# Bootloader stuff
 boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];
 boot.kernelModules = [ "kvm-amd" "vfio-pci" ];

# Libvirt Virtualization
virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
     package = pkgs.qemu_kvm;
      ovmf = {
       enable = true;
       packages = [ pkgs.OVMFFull.fd ];
};
#  Enabling TPM support 
   swtpm.enable = true; 
    runAsRoot = true;
    };
};

  systemd.tmpfiles.rules =
    let
      qemuHook = pkgs.writeShellApplication {
        name = "qemu-hook";

        runtimeInputs = [
          pkgs.libvirt
          pkgs.systemd
          pkgs.kmod
        ];
        text = ''
          GUEST_NAME="$1"
          OPERATION="$2"

          if [ "$GUEST_NAME" == "win10" ]; then
            if [ "$OPERATION" == "prepare/begin" ]; then
		systemctl stop display-manager.service
		modprobe -r amdgpu
		virsh nodedev-detach pci_0000_0b_00_0
                virsh nodedev-detach pci_0000_0b_00_1
		virsh nodedev-detach pci_0000_0d_00_4
		modprobe vfio-pci
          fi
             if [ "$OPERATION" == "release/end" ]; then
              virsh nodedev-reattach pci_0000_0b_00_0
              virsh nodedev-reattach pci_0000_0b_00_1
	      virsh nodedev-reattach pci_0000_0d_00_4
              modprobe -r vfio-pci 
              modprobe amdgpu
              systemctl start display-manager.service
            fi
          fi  
'';

};
    in
    [

       "L+ /var/lib/libvirt/hooks/qemu - - - - ${lib.getExe qemuHook}"
    ]; 
}
