module "lambda" {
  source = "github.com/zikster3262/terraform-aws-modules/lambda"

  lambda_inputs = {
    name    = "hello-world"
    handler = "index.handler"
    runtime = "nodejs16.x"
  }

  archive_file_inputs = {
    archive_type     = "zip"
    source_dir       = "${path.module}/lambda"
    output_path      = "${path.module}/lambda/lambda.zip"
    output_file_mode = "0666"
  }

}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
  depends_on    = [module.lambda]
}
resource "aws_apigatewayv2_integration" "this" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  connection_type    = "INTERNET"
  integration_uri    = module.lambda.invoke_arn
  depends_on         = [module.lambda]
}
