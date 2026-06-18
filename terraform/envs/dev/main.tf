# ============================================
# RECURSO 1: Bucket S3 para el frontend (privado)
# ============================================
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "educloud-frontend-${random_id.suffix.hex}"
  
  tags = {
    Name        = "EduCloud-Frontend"
    Environment = "dev"
    Proyecto    = "EduCloud"
  }
}

# Generar un sufijo aleatorio para que el bucket sea único
resource "random_id" "suffix" {
  byte_length = 4
}

# ============================================
# BLOQUEAR ACCESO PÚBLICO (Seguridad)
# ============================================
resource "aws_s3_bucket_public_access_block" "frontend_block" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ============================================
# POLÍTICA PARA PERMITIR SOLO CLOUDFRONT
# ============================================
resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.frontend_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.frontend_cdn.id}"
          }
        }
      }
    ]
  })
}

# ============================================
# OBTENER EL ID DE LA CUENTA AWS ACTUAL
# ============================================
data "aws_caller_identity" "current" {}

# ============================================
# OUTPUTS: Para ver qué creamos
# ============================================
output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.frontend_bucket.bucket
}

output "s3_bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.frontend_bucket.arn
}