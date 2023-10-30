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

variable "kv_username_secret_name" {
    type = string
    description = "Name of the secret which will hold the username for the VM"
}

variable "username" {
    type = string
    description = "The username for the VM"
}

variable "kv_password_secret_name" {
    type = string
    description = "Name of the secret which will hold the password for the VM"  
}

variable "password" {
    type = string
    description = "The password for the VM"
    sensitive = true
}