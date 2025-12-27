# docs: https://registry.terraform.io/providers/keycloak/keycloak/latest/docs

# =============================================================================
# Keycloak Realm Module
# =============================================================================

module "microservice_app_realm" {
  source = "../../../modules/keycloak-config"

  # Realm settings
  realm_name    = var.realm_name
  realm_enabled = true

  # Login settings
  ssl_required             = "external"
  registration_allowed     = true
  remember_me              = true
  verify_email             = true
  login_with_email_allowed = true
  duplicate_emails_allowed = false
  reset_password_allowed   = true
  edit_username_allowed    = false

  # Token settings (Go duration format)
  access_token_lifespan    = "5m"  # 300 seconds
  sso_session_idle_timeout = "30m" # 1800 seconds
  sso_session_max_lifespan = "10h" # 36000 seconds
  access_code_lifespan     = "1m"  # 60 seconds

  # SMTP settings
  smtp_host              = var.smtp_host
  smtp_port              = var.smtp_port
  smtp_from              = var.smtp_from
  smtp_from_display_name = "Common Authorization Service"
  smtp_starttls          = false
  smtp_ssl               = false
  smtp_auth_enabled      = false

  # ToDo App Backend client
  todo_backend_client_id     = "todo-backend-client"
  todo_backend_client_name   = "ToDo Backend Client"
  todo_backend_client_secret = var.todo_backend_client_secret

  # ToDo App Frontend client
  todo_frontend_client_id   = "todo-frontend-client"
  todo_frontend_client_name = "ToDo Frontend Client"
  todo_frontend_client_url  = var.todo_frontend_client_url

  # Google IdP
  google_idp_enabled       = true
  google_idp_client_id     = var.google_idp_client_id
  google_idp_client_secret = var.google_idp_client_secret
}
