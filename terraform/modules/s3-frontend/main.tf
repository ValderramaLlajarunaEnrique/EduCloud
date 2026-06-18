# ============================================
# MÓDULO: S3 para Frontend
# ============================================

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name != null ? var.bucket_name : "frontend-${random_id.suffix.hex}"
  
  tags = var.tags
}

resource "random_id" "suffix" {
  count       = var.bucket_name == null ? 1 : 0
  byte_length = 4
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}