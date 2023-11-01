locals {
  workspace_suffix = terraform.workspace == "default" ? "" : terraform.workspace

  common_tags = {
    owner              = var.owner
    project            = var.base_name
    company            = var.company
    billing_department = var.billing_department
    configuration      = local.workspace_suffix

  }
}

module "Network" {
  source           = "./network"
  workspace_suffix = local.workspace_suffix
  base_name        = "${var.base_name}net"
  location         = var.location
  source_IP        = var.source_IP
  port             = var.port
  tags             = local.common_tags
}

module "VirtualMachine" {
  source           = "./vm"
  workspace_suffix = local.workspace_suffix
  base_name        = "${var.base_name}vm"
  location         = var.location
  subnet_id        = module.Network.subnet_id
  username         = var.username
  password         = var.password
  tags             = local.common_tags
}
