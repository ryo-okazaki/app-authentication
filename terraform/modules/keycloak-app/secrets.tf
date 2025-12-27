resource "aws_secretsmanager_secret" "terraform_client_secret" {
  name = "keycloak-terraform-client-secret"
}

resource "random_password" "terraform_client_secret" {
  length  = 32
  special = false
}

resource "aws_secretsmanager_secret_version" "terraform_client_secret" {
  secret_id     = aws_secretsmanager_secret.terraform_client_secret.id
  secret_string = random_password.terraform_client_secret.result
}
