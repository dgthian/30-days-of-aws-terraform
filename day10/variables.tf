variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "staging"
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

variable instance_count {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "monitoring" {
  description = "Enable detailed monitoring for EC2 instances"
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the EC2 instances"
  type        = bool
  default     = true
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = list(string)
  default     = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
}

variable "allowed_vm_types" {
  description = "List of allowed VM types for security group ingress rules"
  type        = list(string)
  default     = ["t3.micro", "t3.small", "t3.medium"]
}

variable allow_region {
  description = "The AWS region to create resources in"
  type        = list(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Name        = "dev-EC2-Instance"
    created_by  = "Terraform"
    Compliance   = "yes"
  }
}

variable "tags_security_group" {
  description = "A map of tags to apply to security group resources"
  type        = map(string)
  default     = {
    Name = "allow_tls"
  }
}

variable "ingress_values" {
  description = "A list of maps defining ingress rules for the security group"
  type        =  tuple([number, string, number])
  default     = [443, "tcp", 443] 
}

variable "config" {
  type = object({
    environment = string
    region      = string
    monitoring   = bool
    associate_public_ip = bool
    instance_count = number
  })
  default = {
    environment = "staging"
    region      = "us-east-1"
    monitoring   = true
    associate_public_ip = true
    instance_count = 1
  }
}

variable "bucket_names" {
  description = "List of unique bucket names to create"
  type        = list(string)
  default     = ["my-unique-bucket-name-04052026-01" , "my-unique-bucket-name-04052026-02"]
}

variable "bucket_names_set" {
  description = "Set of unique bucket names to create"
  type = set(string)
  default =  ["my-unique-bucket-name-04052026-03" , "my-unique-bucket-name-04052026-04"] 
}

# ==============================
# Tags
# ==============================

variable "resource_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Team        = "DevOps"
    CostCenter  = "Engineering"
  }
}


variable "ingress_rules" {
  description = "List of maps defining ingress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP traffic from anywhere"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS traffic from anywhere"
    }
  ]
}

locals {
  all_instance_ids = aws_instance.example.*.id // Splat expression to get all instance IDs
}

output "instance_ids" {
  value = local.all_instance_ids
}
