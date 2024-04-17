#Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.21" #Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" #AWS Credentials Profile configured on your local desktop terminal
  region  = "us-east-1"
}

#Resource Block
resource "aws_instance" "linux-terraform-learning" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
}

