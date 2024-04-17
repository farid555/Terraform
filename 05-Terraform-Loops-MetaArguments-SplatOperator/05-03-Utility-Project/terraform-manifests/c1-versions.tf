# Terraform Block
terraform {
  required_version = "~> 1.8.0"
  required_providers {
    aws = { #Local Names of provider aws
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

#Provider Block
provider "aws" { #Name will be same Local Names aws
  region = "us-east-1"
}
