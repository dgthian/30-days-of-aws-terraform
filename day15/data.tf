# Data Sources for VPC Peering Demo

# Data source to get the availability zones in the primary region
data "aws_availability_zones" "primary" {
  provider = aws.primary
  state = "available"
}

# Data source to get the availability zones in the secondary region
data "aws_availability_zones" "secondary" {
  provider = aws.secondary
  state = "available"
}   

# Data source for Primary region AMI (Ubuntu 22.04 LTS)
data "aws_ami" "primary_ubuntu" {
  provider = aws.primary
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

# Data source for Secondary region AMI (Ubuntu 22.04 LTS)
data "aws_ami" "secondary_ubuntu" {
  provider = aws.secondary
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }    
}

 