resource "proxmox_vm_qemu" "k8s-master" {
  count       = var.k8s_master_count
  name        = "k8s-master-0${count.index + 1}"
  target_node = var.pm_hostnames[count.index]
  vmid        = "40${count.index + 1}"
  clone       = var.pm_cloudinit_template
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
    storage = var.pm_storage_name
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
  # ipconfig0 = "ip=${var.lan_network_subnet}.20${count.index + 1}/24,gw=${var.lan_gateway}"
  # ipconfig1 = "ip=${var.k8s_network_subnet}.20${count.index + 1}/24"

  ipconfig0 = "ip=${cidrhost(var.lan_cidr_block, 200 + count.index + 1)}/24,gw=${cidrhost(var.lan_cidr_block, 254)}"
  ipconfig1 = "ip=${cidrhost(cidrsubnet(var.k8s_cidr_block, 8, 1), count.index + 1)}/16"

  sshkeys = <<EOF
  ${var.pm_sshkey}
  EOF
}
