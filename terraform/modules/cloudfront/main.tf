# ============================================
# MÓDULO: CloudFront con S3 Origin
# ============================================

# 1. DISTRIBUCIÓN CLOUDFRONT
resource "aws_cloudfront_distribution" "this" {
  enabled             = var.enabled
  default_root_object = var.default_root_object

  logging_config {
    include_cookies = false
    bucket          = var.log_bucket_name != "" ? var.log_bucket_name : "educloud-cf-logs-${random_id.log_suffix.hex}.s3.amazonaws.com"
    prefix          = "cloudfront-logs/"
  }
  
  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = var.origin_id
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }
  
  default_cache_behavior {
    target_origin_id = var.origin_id
    
    allowed_methods = var.allowed_methods
    cached_methods  = var.cached_methods
    
    forwarded_values {
      query_string = var.forward_query_string
      cookies {
        forward = var.cookie_forward
      }
    }
    
    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }
  
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
    }
  }
  
  viewer_certificate {
    cloudfront_default_certificate = var.use_default_certificate
    ssl_support_method             = var.ssl_support_method
    minimum_protocol_version       = var.minimum_protocol_version
  }
  
  tags = var.tags
}

# 2. ORIGEN DE ACCESO A S3 (OAI)
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = var.oai_comment
}

# 3. POLÍTICA PARA PERMITIR SOLO CLOUDFRONT (se usa en S3)
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipal"
    effect = "Allow"
    
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    
    actions   = ["s3:GetObject"]
    resources = ["${var.s3_bucket_arn}/*"]
    
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.this.id}"]
    }
  }
}

# 4. POLÍTICA DEL BUCKET (para aplicar en S3)
resource "aws_s3_bucket_policy" "this" {
  count  = var.create_s3_policy ? 1 : 0
  bucket = var.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}