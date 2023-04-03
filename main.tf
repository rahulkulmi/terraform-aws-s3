locals {
  s3OriginId         = "origin-${aws_s3_bucket.website.bucket}"
  bucket_domain_name = aws_s3_bucket.website.bucket_domain_name

  tags = merge({
    # repo        = var.repo
    project     = var.project
    app_name    = var.app_name
    app_version = var.app_version
    environment = var.stage
  })
}
