resource "proxmox_vm_qemu" "k8s-storage" {
  count       = 1
  name        = "k8s-storage-0${count.index + 1}"
  target_node = var.pm_hostnames[count.index]
  vmid        = "60${count.index + 1}"
  clone       = local.pm_cloudinit_template
  agent       = 1
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 1
  cpu         = "host"
  memory      = 1024
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  disk {
    slot    = 0
    size    = "32G"
    type    = "scsi"
    storage = local.pm_storage_name
    #storage_type = "zfspool"
    iothread = 1
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  # network {
  #   model  = "virtio"
  #   bridge = "vmbr17"
  # }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  #   ipconfig0 = "ip=10.98.1.6${count.index + 1}/24,gw=10.98.1.1"
  ipconfig1 = "ip=10.17.0.6${count.index + 1}/24"
  sshkeys   = <<EOF
  ${var.pm_sshkey}
  EOF
}
