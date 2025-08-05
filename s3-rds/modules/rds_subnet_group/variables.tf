variable "prefix" {
  description = "Resource name prefix."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group."
  type        = list(string)
}
