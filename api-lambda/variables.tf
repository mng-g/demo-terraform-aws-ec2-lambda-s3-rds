variable "aws_region" {
  description = "AWS region to deploy Lambda"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  description = "Name of the project"
  type        = string
}

# variable "s3_bucket" {
#   description = "S3 bucket name for Lambda code"
#   type        = string
# }

# variable "db_dsn" {
#   description = "Database connection string for Lambda"
#   type        = string
# }

variable "db_name" {
  type        = string
  description = "Database name for the RDS instance"
}

variable "db_username" {
  type        = string
  description = "Database username for the RDS instance"
}

variable "db_password" {
  type        = string
  description = "Database password for the RDS instance"
} 