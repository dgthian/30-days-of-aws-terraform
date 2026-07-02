 
output "environment_name" {
  value = var.environment
}

 output "bucket_name" {
   value = var.bucket_name
 }

 output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}