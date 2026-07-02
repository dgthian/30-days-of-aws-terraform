variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "staging"
}


variable region {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}


variable "bucket_name" {
  default = "eltisgroup-01"
}