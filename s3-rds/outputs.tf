output "current_environment" {
  value = terraform.workspace
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "s3_bucket" {
  value = module.s3.bucket_name
}