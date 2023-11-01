# Resource group to hold the network resources
resource "azurerm_resource_group" "net-rg" {
  name     = "${var.base_name}rg${var.workspace_suffix}"
  location = var.location
  tags     = var.tags
}
# Network security group to decide what traffic is allowed on the network
resource "azurerm_network_security_group" "net-nsg" {
  name                = "${var.base_name}nsg${var.workspace_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.net-rg.name
  # Security rule to allow traffic from a specific IP address on a specific port
  security_rule {
    name                       = "${var.base_name}nsgsecrule${var.workspace_suffix}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.port      # Port to allow access to
    source_address_prefix      = var.source_IP # IP address to allow access from
    destination_address_prefix = "*"
  }
  tags = var.tags
}
# Virtual network to allow resources to communicate with each other
resource "azurerm_virtual_network" "net-vnet" {
  name                = "${var.base_name}vnet${var.workspace_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.net-rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags                = var.tags
}
# A subnet of the virtual network
resource "azurerm_subnet" "net-sn" {
  name                 = "${var.base_name}sn${var.workspace_suffix}"
  resource_group_name  = azurerm_resource_group.net-rg.name
  virtual_network_name = azurerm_virtual_network.net-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
# Assosiate the network security group with the subnet
resource "azurerm_subnet_network_security_group_association" "ex" {
  subnet_id                 = azurerm_subnet.net-sn.id
  network_security_group_id = azurerm_network_security_group.net-nsg.id
}
# Output the subnet ID which is then used by the VM module
output "subnet_id" {
  value = azurerm_subnet.net-sn.id
}