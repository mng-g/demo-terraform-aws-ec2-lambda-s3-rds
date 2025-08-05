variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}

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