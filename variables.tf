variable "state_storage" {
  type        = string
  description = "Storage account created by bootstrap to hold all Terraform state"
}

variable "resource_group" {
  type        = string
  description = "Shared management resource group"
}

variable "region" {
  type        = string
  description = "Region used for all resources"
}

variable "prefix" {
  type        = string
  description = "Prefix appended to all resources"
}