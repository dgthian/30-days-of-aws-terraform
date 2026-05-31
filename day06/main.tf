# Create s3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = local.bucket_name
  tags = local.common_tags

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