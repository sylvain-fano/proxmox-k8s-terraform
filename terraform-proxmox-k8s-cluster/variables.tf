variable "pm_api_url" {
  description = "Proxmox host api endpoint. ie: https://<proxmox_host>:8006/api2/json"
}

variable "pm_api_token_id" {
  sensitive   = true
  description = "Proxmox API Token ID. ie: <username>@pam!<tokenId>"
}

variable "pm_api_token_secret" {
  sensitive   = true
  description = "Proxmox API Secret"
}

variable "pm_hostnames" {
  type        = list(string)
  description = "Proxmox hostnames list"
}

variable "pm_sshkey" {
  sensitive   = true
  description = "SSH Public Key to connect to VM instances"
}

variable "k8s_master_count" {
  default     = 2
  description = "Number of Kubernetes master nodes"
}

variable "k8s_worker_count" {
  default     = 2
  description = "Number of Kubernetes worker nodes"
}

variable "k8s_storage_count" {
  default     = 2
  description = "Number of Kubernetes storage nodes"
}

variable "pm_cloudinit_template" {
  description = "Name of the template to use to deploy VMs"
}

variable "pm_storage_name" {
  description = "Name of the Proxmox storage where to deploy VMs"
}

variable "lan_cidr_block" {
  description = "LAN network CIDR (ie: 192.168.46.0/24)"
}

variable "k8s_cidr_block" {
  description = "Kubernetes network CIDR (ie: 10.0.0.0/16)"
  default     = "10.0.16.0/24"
}
