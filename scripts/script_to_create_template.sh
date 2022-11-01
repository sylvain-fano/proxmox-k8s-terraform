#!/bin/bash

##################################################################
############# Shell script to create template ####################
##################################################################
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "Error: You must be root !"
  exit 1
fi

# Step 1: Download the image
SRC_IMG="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"
IMG_NAME="jammy-server-cloudimg-amd64-disk-kvm.qcow2"
echo "Downloading cloud image ..."
wget -O $IMG_NAME $SRC_IMG

# Step 2: Add QEMU Guest Agent
echo "Installing prerequisites ..."
apt update && apt install -y libguestfs-tools
echo "Customizing cloud image adding qemu-guest-agent ..."
virt-customize --install qemu-guest-agent -a $IMG_NAME

# Step 3: Create a VM in Proxmox with required settings and convert to template
SSH_KEY="/home/sfa/.ssh/id_rsa.pub"
TEMPL_NAME="ubuntu2204-cloudinit"
VMID="9000"
MEM="2048"
DISK_SIZE="32G"
DISK_STOR="vms"
NET_BRIDGE="vmbr0"
echo "Creating VM ..."
qm create $VMID --name $TEMPL_NAME --memory $MEM --net0 virtio,bridge=$NET_BRIDGE
qm importdisk $VMID $IMG_NAME $DISK_STOR
qm set $VMID --scsihw virtio-scsi-pci --scsi0 $DISK_STOR:$VMID/vm-$VMID-disk-0.raw
qm set $VMID --ide2 $DISK_STOR:cloudinit
qm set $VMID --boot c --bootdisk scsi0
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --ipconfig0 ip=dhcp
qm set $VMID --agent enabled=1
qm set $VMID --sshkey $SSH_KEY
qm resize $VMID scsi0 $DISK_SIZE
echo "Creating template from VM..."
qm template $VMID

# Step 4: Removing image
echo "Removing downloaded image..."
rm $IMG_NAME

exit 0