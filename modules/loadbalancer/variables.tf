variable "location" {
    type = string
    default = "US east"
    description = "Location of the resource group."
}

variable "resource_group_name" {
    type = string
    default = "rg"
    description = "Name of the resource group."
}

variable "lb_name" {
  type        = string
  description = "Name of the LB"
  default     = "db-loadbalancer"
}

variable "subnet_id" {
  type        = string
  description = "Loadbalancer subnet"
}
