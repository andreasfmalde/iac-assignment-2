variable "workspace_suffix" {
    type = string
    description = "Value which will hold the suffix for the workspace name"
}

variable "base_name" {
    type = string
    description = "The base name of the module"
}

variable "location" {
    type = string
    description = "The location of where the azure resources will be deployed"
}

variable "source_IP" {
    type = string
    description = "The source IP address to allow SSH access to the VM"
}

variable "port" {
    type = string
    description = "The port to allow access to the VM"
}

variable "tags" {
    type = map(string)
    description = "The tags to be applied to all resources"
}