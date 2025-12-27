# =============================================================================
# Keycloak Provider Configuration
# =============================================================================

provider "keycloak" {
  url = var.keycloak_url
  # Use client credentials grant (recommended for automation)
  client_id     = var.keycloak_admin_client_id
  client_secret = var.keycloak_admin_client_secret

  # Or use password grant (uncomment below and comment out client_secret)
  # username = var.keycloak_admin_username
  # password = var.keycloak_admin_password

  realm = var.realm_for_auth

}
