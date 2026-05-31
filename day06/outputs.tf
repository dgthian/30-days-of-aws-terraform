output "vpc_id" {
  value = aws_vpc.sample.id
}

output "instance_id" {
  value = aws_instance.sample.id
}

output "environment_name" {
  value = var.environment
}

output "storage_account_name" {
  value = aws_s3_bucket.first_bucket.bucket
}