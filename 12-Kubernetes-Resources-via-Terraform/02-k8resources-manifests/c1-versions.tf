# Terraform Setting Block
terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
         version = "~> 2.29"
    }
  }
}



