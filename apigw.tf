
terraform {
  backend "s3" {
    bucket = "tf-states-bucket-fr"
    key    = "terraform/states/api-gw-cognito"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    archive = {
      source = "hashicorp/archive"
    }
  }
}

# Define the AWS provider
provider "aws" {
  region = "eu-central-1" # Replace with your desired region
}

# Create the API Gateway HTTP API
resource "aws_apigatewayv2_api" "this" {
  name          = "awpigw-cognito"
  protocol_type = "HTTP"
}

# Create a default stage for the API
resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "v1"
  auto_deploy = true
}

# Create a default route for the API
resource "aws_apigatewayv2_route" "this" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}

