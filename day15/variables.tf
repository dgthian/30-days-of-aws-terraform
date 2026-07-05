variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "staging"
}

 
variable "primary_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-west-2"
}

variable "primary_vpc_cidr" {
  description = "The CIDR block for the primary VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "secondary_vpc_cidr" {
  description = "The CIDR block for the secondary VPC"
  type        = string
  default     = "10.1.0.0/16"
}


variable "primary_subnet_cidr" {
  description = "The CIDR block for the primary subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "secondary_subnet_cidr" {
  description = "The CIDR block for the secondary subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "primary_key_name" {
  description = "The name of the key pair for the primary region"
  type        = string
  default     = ""
}

variable "secondary_key_name" {
  description = "The name of the key pair for the secondary region"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
  default     = "t3.micro"
} 