# ============================================
# VARIABLES DEL MÓDULO COGNITO
# ============================================

variable "user_pool_name" {
  description = "Nombre del User Pool"
  type        = string
  default     = "educloud-users"
}

variable "client_name" {
  description = "Nombre del cliente"
  type        = string
  default     = "educloud-webapp"
}

variable "minimum_password_length" {
  description = "Longitud mínima de contraseña"
  type        = number
  default     = 8
}

variable "callback_urls" {
  description = "URLs permitidas después del login"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "logout_urls" {
  description = "URLs permitidas después del logout"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "default_redirect_uri" {
  description = "URL por defecto para redireccionamiento"
  type        = string
  default     = "http://localhost:3000"
}

variable "generate_client_secret" {
  description = "Generar secret para el cliente"
  type        = bool
  default     = false
}

variable "create_domain" {
  description = "Crear dominio de autenticación"
  type        = bool
  default     = true
}

variable "domain_prefix" {
  description = "Prefijo del dominio (ej: auth)"
  type        = string
  default     = ""
}

variable "create_admin_group" {
  description = "Crear grupo de administradores"
  type        = bool
  default     = true
}

variable "create_identity_pool" {
  description = "Crear Identity Pool para federación"
  type        = bool
  default     = false
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3 para permisos"
  type        = string
  default     = null
}

variable "tags" {
  description = "Etiquetas para Cognito"
  type        = map(string)
  default     = {}
}