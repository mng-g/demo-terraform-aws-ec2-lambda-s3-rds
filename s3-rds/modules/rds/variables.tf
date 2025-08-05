variable "prefix" {
  description = "Resource name prefix."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)."
  type        = string
}

variable "db_name" {
  description = "Database name."
  type        = string
}

variable "db_username" {
  description = "Master username for the database."
  type        = string
}

variable "db_password" {
  description = "Master password for the database."
  type        = string
  sensitive   = true
}

variable "security_group_id" {
  description = "Security group ID for the RDS instance."
  type        = string
}

variable "db_subnet_group_name" {
  description = "DB subnet group name."
  type        = string
}
