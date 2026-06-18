# ============================================
# OUTPUTS DEL ENTORNO DEV
# ============================================

# Outputs de S3
output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = module.s3_frontend.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN del bucket S3"
  value       = module.s3_frontend.bucket_arn
}

output "s3_bucket_domain" {
  description = "Dominio del bucket S3"
  value       = module.s3_frontend.bucket_domain_name
}

# Outputs de CloudFront
output "cloudfront_domain" {
  description = "Dominio de CloudFront"
  value       = module.cloudfront.cloudfront_domain_name
}

output "cloudfront_distribution_id" {
  description = "ID de la distribución CloudFront"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_url" {
  description = "URL de CloudFront"
  value       = "https://${module.cloudfront.cloudfront_domain_name}"
}

# Output combinado
output "website_url" {
  description = "URL del sitio web"
  value       = "https://${module.cloudfront.cloudfront_domain_name}"
}