locals {
  curl_request = <<-EOT
curl --location --request POST '${aws_cognito_user_pool.this.endpoint}/oauth2/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=${aws_cognito_user_pool_client.this.id}' \
--data-urlencode 'client_secret=${aws_cognito_user_pool_client.this.client_secret}'
  EOT
}
