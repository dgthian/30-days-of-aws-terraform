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

variable "instance_type" {
  default = "t3.micro"

  validation {
    condition     = length(var.instance_type) <= 20 && length(var.instance_type) >= 2
    error_message =  "Instance type must be between 2 and 20 characters long."
  }

  validation {
    condition     = can(regex("^t[2-3]\\.", var.instance_type))
    error_message =  "Instance type must start with 't2.' or 't3.'."
  }
}


  variable "backup_name" {
    default = "daily-backup"

    validation {
      condition     = endswith(var.backup_name, "_backup")
      error_message =  "Backup name must end with '_backup'."
      }
  }


variable  credentials {
  default =  "zaezazea"
  sensitive = true
}

variable "user_locations" {
  default = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "default_locations" {
  default = ["us-west-1"]
}

variable "monthly_cost" {
  default = [-50, 100 , 75, 200] # -50 is a credit
}