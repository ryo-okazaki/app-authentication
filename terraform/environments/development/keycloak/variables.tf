# =============================================================================
# Provider Variables
# =============================================================================

variable "keycloak_url" {
  description = "The URL of the Keycloak instance"
  type        = string
}

variable "keycloak_admin_client_id" {
  description = "The client ID for Terraform to authenticate with Keycloak"
  type        = string
  default     = "admin-cli"
}

variable "keycloak_admin_client_secret" {
  description = "The client secret for Terraform to authenticate with Keycloak (for client credentials grant)"
  type        = string
  sensitive   = true
}

variable "realm_for_auth" {
  description = "The realm to use for authenticating Terraform with Keycloak"
  type        = string
}

# =============================================================================
# Realm Variables
# =============================================================================

variable "realm_name" {
  description = "The name of the realm"
  type        = string
}

# =============================================================================
# SMTP Variables
# =============================================================================

variable "smtp_host" {
  description = "SMTP server host"
  type        = string
}

variable "smtp_port" {
  description = "SMTP server port"
  type        = string
}

variable "smtp_from" {
  description = "SMTP from address"
  type        = string
}

# =============================================================================
# Client Variables
# =============================================================================

variable "todo_backend_client_secret" {
  description = "The client secret for the backend client"
  type        = string
  sensitive   = true
}

variable "todo_frontend_client_url" {
  description = "The URL of the frontend client"
  type        = string
}

# =============================================================================
# Google IdP Variables
# =============================================================================

variable "google_idp_client_id" {
  description = "Google OAuth client ID"
  type        = string
}

variable "google_idp_client_secret" {
  description = "Google OAuth client secret"
  type        = string
  sensitive   = true
}
