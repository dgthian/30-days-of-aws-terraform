locals {
  bucket_name = "lab-bucket-${var.environment}"
  vpc_name = "${var.environment}-VPC"
  common_tags = {
    env   = "dev"
    lob   = "banking"
    stage = "alpha"
  }
}
