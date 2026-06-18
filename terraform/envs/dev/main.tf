# ============================================
# CONFIGURACIÓN PRINCIPAL
# ============================================

# 1. MODULO: S3 para Frontend
module "s3_frontend" {
  source = "../../modules/s3-frontend"
  
  bucket_name = var.bucket_name != "" ? var.bucket_name : null
  
  tags = merge(local.common_tags, {
    Name = "EduCloud-Frontend"
  })
}

# 2. MODULO: CloudFront CDN
module "cloudfront" {
  source = "../../modules/cloudfront"
  
  s3_bucket_domain_name = module.s3_frontend.bucket_domain_name
  s3_bucket_arn         = module.s3_frontend.bucket_arn
  s3_bucket_id          = module.s3_frontend.bucket_id
  
  # Configuración personalizada
  origin_id = "S3FrontendOrigin"
  
  tags = merge(local.common_tags, {
    Name = "EduCloud-CDN"
  })
}