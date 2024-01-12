variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
  default     = "swedencentral"
}

variable "resource_group_name" {
  description = "The name of the resource group in which all resources in this example should be created."
  type        = string
}

variable "amount_of_vms_with_private_ip" {
  description = "The amount of VMs to create."
  type        = number
  default     = 1
}

variable "amount_of_vms_with_public_ip" {
  description = "The amount of VMs to create."
  type        = number
  default     = 1
}

variable "allow_ip_adress" {
  description = "The IP address to allow access from."
  type        = string
}
