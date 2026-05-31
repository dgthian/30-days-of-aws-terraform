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
