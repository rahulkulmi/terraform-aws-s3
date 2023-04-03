resource "aws_s3_bucket" "website" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_acl" "website_acl" {
  bucket = aws_s3_bucket.website.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "website-policy" {
  bucket = aws_s3_bucket.website.bucket # aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.this.json
}

# resource "aws_s3_bucket_website_configuration" "website-config" {
#   bucket = aws_s3_bucket.website.bucket
#   index_document {
#     suffix = "index.html"
#   }
# }
