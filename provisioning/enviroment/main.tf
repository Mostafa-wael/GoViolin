terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "default"
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


