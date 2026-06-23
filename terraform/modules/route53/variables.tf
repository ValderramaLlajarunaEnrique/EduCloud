# ============================================
# VARIABLES DEL MÓDULO ROUTE53
# ============================================

variable "domain_name" {
  description = "Nombre del dominio (ej: educloud.com)"
  type        = string
}

variable "subdomain" {
  description = "Subdominio (ej: www, app, api)"
  type        = string
  default     = ""
}

variable "create_hosted_zone" {
  description = "Crear nuevo Hosted Zone en Route53"
  type        = bool
  default     = false
}

variable "create_www_record" {
  description = "Crear registro www.example.com"
  type        = bool
  default     = true
}

variable "cloudfront_domain_name" {
  description = "Nombre de dominio de CloudFront"
  type        = string
  default     = null
}

variable "cloudfront_hosted_zone_id" {
  description = "Hosted Zone ID de CloudFront"
  type        = string
  default     = null
}

variable "tags" {
  description = "Etiquetas para Route53"
  type        = map(string)
  default     = {}
}