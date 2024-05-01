# Define Local Values in Terraform
locals {
  owners = var.business_divsion          # business_divsion - SAP
  environment = var.environment          # environment - dev
  name = "${var.business_divsion}-${var.environment}" # [SAP-dev]
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 