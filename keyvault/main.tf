data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "kv-rg" {
  name     = "${var.base_name}rg${var.workspace_suffix}"
  location = var.location
  tags     = var.tags
}


resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_key_vault" "kv-kv" {
  name                        = "${var.base_name}${random_string.random.result}kv${var.workspace_suffix}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.kv-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions     = ["Get", "List", "Create", "Delete", "Purge", "Recover"]
    secret_permissions  = ["Get", "List", "Set", "Delete", "Purge", "Recover"]
    storage_permissions = ["Get", "Set", "Delete", "List"]
  }
  tags = var.tags
}

resource "azurerm_key_vault_secret" "kv_secret_vm_username" {
  name         = var.kv_username_secret_name
  value        = var.username
  key_vault_id = azurerm_key_vault.kv-kv.id
}

resource "azurerm_key_vault_secret" "kv_secret_vm_password" {
  name         = var.kv_password_secret_name
  value        = var.password
  key_vault_id = azurerm_key_vault.kv-kv.id
}