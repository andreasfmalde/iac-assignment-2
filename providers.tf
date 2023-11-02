# Terrafrom provider configuration
terraform {
  required_version = ">= 1.5" # Minimum required version of Terraform
  required_providers {
    azurerm = { # Azure provider
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }
      random = { # Random string provider
    source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  # Backend configuration to store the Terraform state file in Azure Storage
  backend "azurerm" {
    resource_group_name  = "afmbackend-rg"       # Resource group name of the backend storage
    storage_account_name = "afmbackendsam7q5ab"  # Name of the backend storage account
    container_name       = "tfstate"             # Name of the container to store the Terraform state file
    key                  = "assignment2.tfstate" # The name of the Terraform state file to hold the state
  }
}
# Provider specific configuration
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}