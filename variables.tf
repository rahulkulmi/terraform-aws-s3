# Generic variables
variable "tags" {
  type        = map(string)
  description = "Default tags map"
  default     = {}
}

variable "project" {
  default = "Newput"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "stage" {
  type        = string
  description = "SDLC stage (e.g. dev, qa etc)"
}

# CloudFront configuration
variable "bucket_name" {
  description = "Name of the S3 bucket where the assets are stored"
  type        = string
}

variable "certificate_arn" {
  description = "SSL certificate ARN to use with CloudFront"
  type        = string
}

# variable "web_acl_id" {
#   type        = string
#   description = "WAF ACL id - usually used to limit access to endpoints from public"
#   default     = null
# }

variable "forwarded_headers" {
  default = ["Origin"]
}

variable "forwarded_cookies" {
  default = "none"
}

variable "forwarded_query_string" {
  default = true
}

variable "custom_error_response" {
  description = "One or more custom error response elements"
  type        = any
  default     = {}
}

# Route53 configuration
variable "domain_name" {
  # type        = list(string)
  type        = string
  description = "The domain name for the website."
}

variable "hosted_zone_id" {
  description = "the route 53 zone id where the alias should be created"
  type        = string
}

/*
# Edge Lambda variables (leave edge_lambda_content == null to avoid lambda provisioning)
variable "edge_lambda_content" {
  description = "lambda@edge nodejs handler function path"
  type        = string
  default     = null
}

variable "lambda_runtime" {
  type        = string
  description = "NodeJS runtime version for Lambda function"
  default     = "nodejs14.x"
}

variable "lambda_memory" {
  type        = number
  description = "Lambda function memory to allocate"
  default     = 128
}

variable "lambda_execution_timeout" {
  type        = number
  description = "Execution timeout for Lambda function"
  default     = 3
}
*/
