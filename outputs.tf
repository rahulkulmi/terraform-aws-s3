output "bucket" {
  description = "Origins S3 bucket"
  value       = aws_s3_bucket.website.bucket
}

# output "lambda_arn" {
#   description = "lambda@edge ARN"
#   value       = var.edge_lambda_content != null ? aws_lambda_function.edge_lambda[0].arn : null
# }

output "cloudfront_distribution_id" {
  description = "CloudFront distrubution id"
  value       = aws_cloudfront_distribution.this.id
}
