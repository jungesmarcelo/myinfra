variable "PROXMOX_TOKEN_ADDRESS" { type = string }
variable "PROXMOX_TOKEN_ID" { type = string }
variable "PROXMOX_TOKEN_SECRET" { type = string }

terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}

provider "proxmox" {
  pm_api_url   = "var.PROXMOX_ADDRESS"
  pm_api_token_id      = "var.PROXMOX_TOKEN_ID"
  pm_api_token_secret  = "var.PROXMOX_TOKEN_SECRET"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "my_vm-cloud-init" {
  name       = "lfs258-01"
  target_node = "aurelio"
  clone      = "fedora41-cloudinit"
  cores      = 4
  memory     = 4096
  storage = "32G"
  ipconfig0 = "ip=192.168.4.199/24,gw=192.168.4.1"
  sshkeys = <<EOF
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOdq/p7BC/5OnNW38X9tpeND+qvdS8YfkBw0E+11a7of marcelojunges@skyline.local
EOF
}


