locals {
  owner = var.department
  environment = var.env
  name = "${var.department}-${var.env}"
  common_tags = {
    owner = local.owner
    environment = local.environment
  }
}