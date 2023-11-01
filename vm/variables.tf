variable "workspace_suffix" {
  type        = string
  description = "Value which will hold the suffix for the workspace name"
}

variable "base_name" {
  type        = string
  description = "The base name of the module"
}

variable "location" {
  type        = string
  description = "The location of where the azure resources will be deployed"
}

variable "subnet_id" {
  type        = string
  description = "The subnet id where the VM will be deployed"
}

variable "username" {
  type        = string
  description = "The username for the VM"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "The password for the VM"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "The tags to be applied to all resources"
}