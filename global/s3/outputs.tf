output "s3_bucket_arn" {
  value       = aws_s3_bucket.jinju-s3bucket.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.jinju-dynamodbtable.name
  description = "The name of the DynamoDB table"
}
