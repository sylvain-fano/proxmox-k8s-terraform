terraform {
  backend "s3" {
    bucket         = "fano-terraform-backend"
    key            = "tlc/prod/proxmox-k8s.tfstate"
    region         = "eu-west-3"
    encrypt        = "true"
    dynamodb_table = "fano-terraform-backend"
  }
}
