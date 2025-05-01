terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for static website hosting
resource "aws_s3_bucket" "crypto_compass" {
  bucket = "crypto-compass-static-website"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# CloudFront distribution
resource "aws_cloudfront_distribution" "crypto_compass" {
  origin {
    domain_name = aws_s3_bucket.crypto_compass.bucket_regional_domain_name
    origin_id   = "S3-crypto-compass"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.crypto_compass.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-crypto-compass"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl           = 3600
    max_ttl              = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# CloudFront OAI
resource "aws_cloudfront_origin_access_identity" "crypto_compass" {
  comment = "OAI for crypto compass"
}

# S3 Bucket Policy
resource "aws_s3_bucket_policy" "crypto_compass" {
  bucket = aws_s3_bucket.crypto_compass.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.crypto_compass.arn}/*"
      }
    ]
  })
}

# Lambda function for price updates
resource "aws_lambda_function" "price_updater" {
  filename         = "price_updater.zip"
  function_name    = "crypto-compass-price-updater"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  timeout          = 30
  memory_size      = 128

  environment {
    variables = {
      COINGECKO_API_KEY = var.coingecko_api_key
    }
  }
}

# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "crypto-compass-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# CloudWatch Event Rule for Lambda trigger
resource "aws_cloudwatch_event_rule" "price_update" {
  name                = "crypto-compass-price-update"
  description         = "Trigger price updates every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

# CloudWatch Event Target
resource "aws_cloudwatch_event_target" "price_update" {
  rule      = aws_cloudwatch_event_rule.price_update.name
  target_id = "PriceUpdater"
  arn       = aws_lambda_function.price_updater.arn
}

# Lambda Permission
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.price_updater.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.price_update.arn
}

# Outputs
output "website_url" {
  value = aws_cloudfront_distribution.crypto_compass.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.crypto_compass.bucket
} 