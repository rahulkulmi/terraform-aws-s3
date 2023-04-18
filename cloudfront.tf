# AWS Cloudfront for caching

# resource "aws_cloudfront_origin_access_control" "this" {
#   name                              = "${var.app_name}-${var.stage}"
#   description                       = "${var.app_name}-${var.stage}-Policy"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Origin Access Identity for origin: ${local.s3OriginId}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.website.bucket_domain_name
    origin_id   = local.s3OriginId

    # origin_access_control_id = aws_cloudfront_origin_access_control.this.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  # domain_name = replace(aws_api_gateway_deployment.deployment.invoke_url, "/^https?://([^/]*).*/", "$1")
  /*origin {
    domain_name = var.record_name
    origin_id   = "${var.app_name}-${var.stage}-server-url"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }*/

  aliases = ["${var.domain_name}"] # var.domain_names

  price_class         = "PriceClass_100" # US/EU  edge locations only
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.app_name}-${var.stage}"
  default_root_object = "index.html"
  # web_acl_id          = var.web_acl_id

  /*
  dynamic "custom_error_response" {
    for_each = var.custom_error_response

    content {
      error_code = custom_error_response.value["error_code"]

      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
    }
  }
  */

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"] # "DELETE", "OPTIONS", "PATCH", "POST", "PUT"
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3OriginId
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      headers      = var.forwarded_headers
      query_string = var.forwarded_query_string
      cookies {
        forward = var.forwarded_cookies
      }
    }
    /*
    dynamic "lambda_function_association" {
      for_each = var.edge_lambda_content != null ? [var.edge_lambda_content] : []
      content {
        event_type = "origin-request"
        lambda_arn = aws_lambda_function.edge_lambda[0].qualified_arn
      }
    }
    */
  }

  /*ordered_cache_behavior {
    path_pattern           = "/api/*"
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.app_name}-${var.stage}-server-url"
    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 0
    min_ttl                = 0
    max_ttl                = 0

    forwarded_values {
      headers      = var.forwarded_headers
      query_string = var.forwarded_query_string
      cookies {
        forward = var.forwarded_cookies
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_response

    content {
      error_code = custom_error_response.value["error_code"]

      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
    }
  }*/

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn # data.aws_acm_certificate.ssl_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
    # cloudfront_default_certificate = true
  }

  tags = var.tags
}
/*
resource "null_resource" "invalidate_cf_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.s3_distribution.id} --paths '/*'"
  }

  triggers = {
    website_version_changed = aws_s3_bucket.website.version_id
  }

  depends_on = [aws_s3_bucket_versioning.website_versioning]
}

resource "aws_cloudfront_function" "rewrite_uri" {
  name    = "rewrite-request-${var.app_name}-${var.stage}"
  comment = "forward request to backend server if receive api call"
  runtime = "cloudfront-js-1.0"
  code    = file("${path.module}/function.js")
}
*/
