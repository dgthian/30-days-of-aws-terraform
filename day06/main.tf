

# Create s3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "lab-bucket-terraform-2026"

  tags = {
    Name        = "My bucket 2.0"
    Environment = "Dev"
  }
}