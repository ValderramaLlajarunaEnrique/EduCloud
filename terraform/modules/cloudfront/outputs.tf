# ============================================
# OUTPUTS DEL MÓDULO CLOUDFRONT
# ============================================

output "cloudfront_distribution_id" {
  description = "ID de la distribución CloudFront"
  value       = aws_cloudfront_distribution.this.id
}

output "cloudfront_domain_name" {
  description = "Nombre de dominio de CloudFront"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_arn" {
  description = "ARN de la distribución CloudFront"
  value       = aws_cloudfront_distribution.this.arn
}

output "cloudfront_hosted_zone_id" {
  description = "Hosted Zone ID de CloudFront"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "origin_access_identity_iam_arn" {
  description = "ARN de la OAI"
  value       = aws_cloudfront_origin_access_identity.oai.iam_arn
}

output "origin_access_identity_path" {
  description = "Path de la OAI"
  value       = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
}

output "s3_bucket_policy_json" {
  description = "Política JSON para S3"
  value       = data.aws_iam_policy_document.s3_policy.json
}