locals {
  workspace_suffix = workspace.name == "default" ? "" : "${workspace.name}"

  common_tags = {
    owner              = var.owner
    project            = var.base_name
    company            = var.company
    billing_department = var.billing_department
    configuration      = local.workspace_suffix

  }
}

module "KeyVault" {
    source = "./keyvault"
    workspace_suffix = local.workspace_suffix
    base_name = "${var.base_name}vault"
    location = var.location
    kv_username_secret_name = var.kv_username_secret_name
    kv_password_secret_name = var.kv_password_secret_name
    username = var.username
    password = var.password
    tags = local.common_tags
}

module "Network" {
    source = "./network"
    workspace_suffix = local.workspace_suffix
    base_name = "${var.base_name}network"
    location = var.location
    source_IP = var.source_IP
    port = var.port
    tags = local.common_tags
}

module "VirtualMachine" {
    source = "./vm"
    workspace_suffix = local.workspace_suffix
    base_name = "${var.base_name}vm"
    location = var.location
    subnet_id = module.Network.subnet_id
    username = var.username
    password = var.password
    tags = local.common_tags
}
