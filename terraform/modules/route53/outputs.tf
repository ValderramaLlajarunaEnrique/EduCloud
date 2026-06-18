# ============================================
# OUTPUTS DEL MÓDULO ROUTE53
# ============================================

output "zone_id" {
  description = "ID del Hosted Zone"
  value       = local.zone_id
}

output "domain_name" {
  description = "Nombre del dominio"
  value       = var.domain_name
}

output "full_domain" {
  description = "Dominio completo (ej: app.educloud.com)"
  value       = var.subdomain != "" ? "${var.subdomain}.${var.domain_name}" : var.domain_name
}