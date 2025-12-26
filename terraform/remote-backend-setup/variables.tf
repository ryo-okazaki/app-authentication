variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name for Shared Admin account"
  type        = string
  default     = "shared-admin"
}

variable "environments" {
  description = "Map of environments with their S3 bucket configurations"
  type = map(object({
    bucket_name          = string
    allowed_account_arns = list(string)
  }))
}
