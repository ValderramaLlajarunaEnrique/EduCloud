# ============================================
# VARIABLES DEL ENTORNO DEV
# ============================================

variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Nombre del entorno"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "EduCloud"
}

variable "bucket_name" {
  description = "Nombre del bucket S3 (vacío = generación automática)"
  type        = string
  default     = ""
}

# ============================================
# ETIQUETAS COMUNES
# ============================================

locals {
  common_tags = {
    Environment = var.environment
    Proyecto    = var.project_name
    ManagedBy   = "Terraform"
  }
}