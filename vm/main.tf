resource "azurerm_resource_group" "vm-rg" {
  name     = "${var.base_name}-rg-${var.workspace_suffix}"
  location = var.location
}

resource "azurerm_public_ip" "vm-pip" {
  name                = "${var.base_name}-pip-${var.workspace_suffix}"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = var.location
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "vm-nic" {
  name                = "${var.base_name}-nic-${var.workspace_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm-rg.name

  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.nic_ip_configuration_private_IP
    public_ip_address_id          = azurerm_public_ip.vm-pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-vm" {
  name                            = "${var.base_name}-vm"
  resource_group_name             = azurerm_resource_group.vm-rg.name
  location                        = var.location
  size                            = var.VM_size
  admin_username                  = tomap(jsondecode(data.azurerm_key_vault_secret.vm-secret.value)).username
  admin_password                  = tomap(jsondecode(data.azurerm_key_vault_secret.vm-secret.value)).password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id,
  ]

  os_disk {
    caching              = var.OS_caching
    storage_account_type = var.OS_StorageAccount_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = var.source_image_sku
    version   = "latest"
  }
}

output "PublicIP" {
  value = azurerm_public_ip.vm-pip.ip_address
}
