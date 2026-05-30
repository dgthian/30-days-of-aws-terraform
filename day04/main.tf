terraform {

  backend "s3" {
    bucket = "lab-terraform-state-2026"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create s3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "lab-bucket-terraform-2026"

  tags = {
    Name        = "My bucket 2.0"
    Environment = "Dev"
  }
}