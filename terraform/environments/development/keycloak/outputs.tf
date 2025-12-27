# =============================================================================
# Outputs
# =============================================================================

output "realm_id" {
  description = "The ID of the created realm"
  value       = module.microservice_app_realm.realm_id
}

output "realm_name" {
  description = "The name of the created realm"
  value       = module.microservice_app_realm.realm_name
}

output "backend_client_id" {
  description = "The Keycloak internal ID of the backend client"
  value       = module.microservice_app_realm.todo_backend_client_id
}

output "backend_client_client_id" {
  description = "The client_id of the backend client"
  value       = module.microservice_app_realm.todo_backend_client_client_id
}

output "frontend_client_id" {
  description = "The Keycloak internal ID of the frontend client"
  value       = module.microservice_app_realm.todo_frontend_client_id
}

output "frontend_client_client_id" {
  description = "The client_id of the frontend client"
  value       = module.microservice_app_realm.todo_frontend_client_client_id
}

output "google_idp_alias" {
  description = "The alias of the Google identity provider"
  value       = module.microservice_app_realm.google_idp_alias
}

output "auto_create_user_flow_alias" {
  description = "The alias of the auto-create-user-first-login flow"
  value       = module.microservice_app_realm.auto_create_user_flow_alias
}
