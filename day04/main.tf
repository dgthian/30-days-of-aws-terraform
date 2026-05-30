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

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "ev"
}

variable channel_name {
  description = "The name of the channel"
  type        = string
  default     = "ttwp"
}

variable region {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

locals {
  bucket_name = "lab-bucket-${var.environment}"
  vpc_name = "${var.environment}-VPC"
}

# Create s3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = "local.bucket_name"
    Environment = var.environment
  }
}

resource "aws_vpc" "sample" {
  cidr_block = "10.0.0.0/16"
  region     = var.region
  tags = {
    Environment = var.environment
    Name        = local.vpc_name
    }
}

resource "aws_instance" "sample" {
  ami           = "ami-00e801948462f718a"
  instance_type = "t3.micro"
  region        = var.region
  tags = {
    Environment = var.environment
    Name        = "${var.environment}-EC2-Instance"
  }
}

output "vpc_id" {
  value = aws_vpc.sample.id
}

output "instance_id" {
  value = aws_instance.sample.id
}