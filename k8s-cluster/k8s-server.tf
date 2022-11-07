resource "proxmox_vm_qemu" "k8s-server" {
  count       = 2
  name        = "k8s-server-0${count.index + 1}"
  target_node = var.pm_hostnames[count.index]
  vmid        = "40${count.index + 1}"
  clone       = local.pm_cloudinit_template
  agent       = 1
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 1
  cpu         = "host"
  memory      = 2048
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
  #   ipconfig0 = "ip=${local.lan_network_subnet}.4${count.index + 1}/24,gw=${local.lan_gateway}"
  ipconfig1 = "ip=${local.k8s_network_subnet}.4${count.index + 1}/24"
  sshkeys   = <<EOF
  ${var.pm_sshkey}
  EOF
}
