variable "base_name" {
  type        = string
  description = "The base name of the infrastructure"
  default     = "afmoterra"
}

variable "location" {
  type        = string
  description = "The location of where the azure resources will be deployed"
  default     = "West Europe"
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

variable "source_IP" {
  type        = string
  description = "The source IP address to allow SSH access to the VM"
  sensitive   = true
}

variable "port" {
  type        = string
  description = "The port to allow access to the VM"
  default     = "22"
}

variable "owner" {
  type        = string
  description = "The owner of the infrastructure"
  default     = "Andreas Malde"
}

variable "company" {
  type        = string
  description = "The company name"
  default     = "Operaterra"
}

variable "billing_department" {
  type        = string
  description = "The billing department"
  default     = "IT"
}
