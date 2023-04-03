# S3
data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.website.arn,
      "${aws_s3_bucket.website.arn}/*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.this.iam_arn, # "*"
      ]
    }
  }
}

/*
data "aws_acm_certificate" "ssl_cert" {
  domain      = var.certificate_name
  most_recent = true
  statuses    = ["ISSUED"]
  provider    = aws.virginia
}

data "aws_route53_zone" "main" {
  # provider = aws.dns
  name = var.hosted_zone_name
}
*/
