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
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-vm" {
  name                            = "${var.base_name}-vm-${var.workspace_suffix}"
  resource_group_name             = azurerm_resource_group.vm-rg.name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

output "PublicIP" {
  value = azurerm_public_ip.vm-pip.ip_address
}
