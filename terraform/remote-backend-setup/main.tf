# =============================================================================
# Terraform State Backend Setup (Shared Admin Account)
# 環境ごとにS3バケットを作成
# =============================================================================

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# -----------------------------------------------------------------------------
# S3 Buckets for Terraform State (per environment)
# -----------------------------------------------------------------------------
resource "aws_s3_bucket" "terraform_state" {
  for_each = var.environments

  bucket = each.value.bucket_name

  tags = {
    Name        = each.value.bucket_name
    Environment = each.key
    Purpose     = "Terraform State Storage"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  for_each = var.environments

  bucket = aws_s3_bucket.terraform_state[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  for_each = var.environments

  bucket = aws_s3_bucket.terraform_state[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  for_each = var.environments

  bucket = aws_s3_bucket.terraform_state[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# -----------------------------------------------------------------------------
# S3 Bucket Policy - Cross Account Access (per environment)
# -----------------------------------------------------------------------------
resource "aws_s3_bucket_policy" "terraform_state" {
  for_each = var.environments

  bucket = aws_s3_bucket.terraform_state[each.key].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCrossAccountAccess"
        Effect = "Allow"
        Principal = {
          AWS = each.value.allowed_account_arns
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.terraform_state[each.key].arn,
          "${aws_s3_bucket.terraform_state[each.key].arn}/*"
        ]
      }
    ]
  })
}
