# ============================================
# OUTPUTS DEL MÓDULO COGNITO
# ============================================

output "user_pool_id" {
  description = "ID del User Pool"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_arn" {
  description = "ARN del User Pool"
  value       = aws_cognito_user_pool.this.arn
}

output "client_id" {
  description = "ID del cliente"
  value       = aws_cognito_user_pool_client.this.id
}

output "client_secret" {
  description = "Secret del cliente (si se generó)"
  value       = aws_cognito_user_pool_client.this.client_secret
  sensitive   = true
}

output "domain" {
  description = "Dominio de autenticación"
  value       = try(aws_cognito_user_pool_domain.this[0].domain, null)
}

output "identity_pool_id" {
  description = "ID del Identity Pool"
  value       = try(aws_cognito_identity_pool.this[0].id, null)
}

output "login_url" {
  description = "URL de login"
  value       = try(aws_cognito_user_pool_domain.this[0].domain, null) != null ? "https://${aws_cognito_user_pool_domain.this[0].domain}.auth.${data.aws_region.current.name}.amazoncognito.com/login" : null
}