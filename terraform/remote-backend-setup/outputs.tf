output "state_buckets" {
  description = "Map of environment to S3 bucket information"
  value = {
    for env, config in var.environments : env => {
      bucket_name = aws_s3_bucket.terraform_state[env].id
      bucket_arn  = aws_s3_bucket.terraform_state[env].arn
      region      = var.region
    }
  }
}
