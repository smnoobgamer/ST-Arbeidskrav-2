variable "vnet_name" {
  type        = string
  default     = "vnet"
  description = "Name for the Virtual Network"
}

variable "location" {
  type        = string
  default = "US east"
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  default     = "rg"
  description = "Name for the resource group"
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
