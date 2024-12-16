variable "location" {
  type        = string
  description = "Azure region"
  default     = "Norway East"
}


variable "admin_username" {
  type        = string
  description = "Admin user"
  default     = "admin"
}

variable "admin_password" {
  type        = string
  description = "Admin password"
  default     = "admin"
}

variable "resource_group_name" {
  type        = string
  default = "rg"
  description = "Resource group name"
}

# Nettverk
variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
  default     = "myVNet"
}

variable "address_space" {
  type        = list(string)
  description = "Network Address"
  default = [ "10.0.0.0/16" ]
}


variable "db_subnet_name" {
  type        = string
  description = "Name for subnet 1"
  default = "subnet1"
}

variable "db_subnet_prefix" {
  type         = string
  description  = "Address of subnet 1"
  default      = "10.0.0.0/24"
}

variable "web_subnet_name" {
  type        = string
  description  = "Name of subnet 2"
  default = "subnet2"
}

variable "web_subnet_prefix" {
  type         = string
  description  = "Address of subnet 2"
  default      = "10.0.1.0/24"
}

# VM-size
variable "web_vm_size" {
  type        = string
  description = "VM size"
  default     = "Standard_DS1_v2"
}

variable "db_vm_size" {
  type        = string
  description = "vm size"
  default     = "Standard_DS1_v2"
}

#VM
variable "web_vm_name" {
  type = string
  description = "Name of web db"
  default = "MyVM"
}

variable "web_script_url" {
  type = string
  description = "URL for web script"
}

variable "vm_count" {
  type = number
  default = 1
  description = "How many VMs"
}

variable "db_vm_name" {
  type = string
  description = "Name of db VMs"
  default = "myVM"
}
variable "db_script_url" {
  type = string
  description = "URL for DB script"
}