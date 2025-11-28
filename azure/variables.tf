variable "location" {
  default = "eastus"
}

variable "resource_group_name" {
  default = "capstone-rg"
}

variable "vm_admin_username" {
  default = "azureuser"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/netrika-key.pub"
}

variable "vm_size" {
  default = "Standard_B2ms"  # policy compliant
}

