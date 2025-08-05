variable "prefix" {
  description = "Resource name prefix."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)."
  type        = string
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}