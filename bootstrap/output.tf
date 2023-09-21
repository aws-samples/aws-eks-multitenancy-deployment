output "s3_bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "dynamodb_id" {
  value = aws_dynamodb_table.terraform-lock.id
}
