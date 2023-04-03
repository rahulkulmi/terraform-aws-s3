/*
resource "random_string" "random" {
  count   = var.edge_lambda_content != null ? 1 : 0
  length  = 8
  special = false
}

resource "aws_iam_role" "edge_lambda" {
  count              = var.edge_lambda_content != null ? 1 : 0
  name_prefix        = "${var.app_name}-${var.stage}"
  assume_role_policy = data.aws_iam_policy_document.edge_lambda[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "edge_lambda" {
  count      = var.edge_lambda_content != null ? 1 : 0
  role       = aws_iam_role.edge_lambda[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "edge_lambda" {
  count            = var.edge_lambda_content != null ? 1 : 0
  function_name    = "${var.app_name}-${var.stage}-edge_lambda"
  filename         = data.archive_file.edge_lambda[0].output_path
  source_code_hash = data.archive_file.edge_lambda[0].output_base64sha256
  role             = aws_iam_role.edge_lambda[0].arn
  runtime          = var.lambda_runtime
  handler          = "index.handler"
  memory_size      = var.lambda_memory
  timeout          = var.lambda_execution_timeout
  publish          = true
  description      = "Lambda@Edge: Handle ${var.app_name}-${var.stage} requests"

  tags = var.tags
}
*/