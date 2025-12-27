variable "env" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "db_endpoint" {
  type = string
}

variable "db_password_arn" {
  type = string
}

variable "admin_password_arn" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "terraform_client_secret_arn" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "bastion_sg_id" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "rds_sg_id" {
  description = "RDS security group ID"
  type        = string
}

# --- SES SMTP Variables ---
variable "ses_smtp_credentials_secret_arn" {
  description = "ARN of Secrets Manager secret containing SES SMTP credentials"
  type        = string
}

variable "ses_smtp_endpoint" {
  description = "SES SMTP endpoint"
  type        = string
}

variable "ses_smtp_port" {
  description = "SES SMTP port"
  type        = number
}

variable "ses_from_email" {
  description = "From email address for Keycloak"
  type        = string
}

variable "ses_from_display_name" {
  description = "Display name for from email"
  type        = string
}
