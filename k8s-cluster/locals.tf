locals {
  prefix                = "fano-terraform-proxmox"
  ssm_prefix            = "/me/fano/terraform/proxmox/"
  pm_cloudinit_template = "ubuntu-2204-cloudinit"
  pm_storage_name       = "vms"
  lan_network_subnet    = "192.168.16"
  lan_gateway           = "192.168.16.254"
  k8s_network_subnet    = "10.17.0"
  common_tags = {
    Project   = "Proxmox K8S Cluster"
    ManagedBy = "Terraform"
  }
}
