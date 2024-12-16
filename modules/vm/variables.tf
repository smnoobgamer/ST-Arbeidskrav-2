variable "vm_name" {
  type        = string
  description = "Navnet på VM-en"
  default = "myVM"
}

variable "location" {
    type = string
    default = "US east"
    description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Navnet på ressursgruppen"
}

variable "subnet_id" {
  type        = string
  description = "ID-en til subnettet VM-en skal være i"
}

variable "vm_size" {
  type        = string
  description = "Størrelsen på VM-en"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username"
  default = "admin"
}

variable "admin_password" {
  type        = string
  description = "Admin Password"
  default     = "admin"
}
variable "assign_public_ip" {
  type        = bool
  description = "Skal VM ha offentleg IP"
  default     = false
}
variable "backend_pool_id" {
  type        = string
  description = "ID of the load balancer backend pool"
  default     = null
}
variable "nsg_id" {
  type        = string
  description = "ID of the network security group"
  default     = null
}
variable "storage_account_name" {
  type        = string
  description = "Name of the storage account for scripts"
  default     = "MariaDBInstall"
}

variable "storage_account_key" {
  type        = string
  description = "Storage account key for script access"
  sensitive   = true

}

variable "image_publisher" {
  description = "Image publisher for VM"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Image offer for VM"
  type        = string
  default     = "ubuntu-24_04-lts"
}

variable "image_sku" {
  description = "Image SKU for VM"
  type        = string
  default     = "server"
}

variable "image_version" {
  description = "Image version for VM"
  type        = string
  default     = "latest"
}

variable "install_script_url" {
  description = "URL to the MariaDB installation script"
  type        = string
  default     = "mariadbinstalltest"
}