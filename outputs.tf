

output "endpoint_cognito" {
  value = aws_cognito_user_pool.this.endpoint
}

output "curl_request" {
  value = nonsensitive(local.curl_request)
}

