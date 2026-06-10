variable "project_name" {
  default = "Project ALPHA Resource"
}

variable "default_tags" {
  default     = {  
    company = "TechCorp"
    managed_by = "terraform"
  }
}

variable "bucket_name" { 
  default = "ProjectAlphaStorage with CAPS and spaces!!!"
}

variable "environment_tags" {
  default     = {
    environment = "production"
    cost_cent     = "cc-123"
  }
}

variable "allowed_ports" {
  default = "22,80,443,8080,3306"
}

variable "instance_size"  {
  default = {
    dev = "t3.micro"
    staging = "t3.small"
    production = "t3.medium"
  }
}

variable "environment" { 
  default = "dev"
}