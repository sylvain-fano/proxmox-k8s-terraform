variable "pm_api_url" {
  description = "Proxmox host api endpoint. ie: https://<proxmox_host>:8006/api2/json"
}

variable "pm_api_token_id" {
  sensitive = true
  description = "Proxmox API Token ID. ie: <username>@pam!<tokenId>"
}

variable "pm_api_token_secret" {
  sensitive = true
  description = "Proxmox API Secret"
}

variable "pm_tls_insecure" {
  default     = true
  description = "Whether if your proxmox host has a self-signed certificate or not. Leave to true if you don't know"
}

variable "pm_hostnames" {
  type = list(string)  
  description = "Proxmox hostnames list"
}

variable "pm_sshkey" {
  sensitive = true
  description = "SSH Public Key to connect to VM instances"
}

variable "k8s_master_count" {
  default = 2
  description = "Number of Kubernetes master nodes"    
}

variable "k8s_worker_count" {
  default = 2
  description = "Number of Kubernetes worker nodes"
}

variable "k8s_storage_count" {
  default = 2
  description = "Number of Kubernetes storage nodes"
}
