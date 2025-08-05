variable "vpc_id" {
  description = "The VPC ID to associate with the security group."
  type        = string
}

variable "prefix" {
  description = "Resource name prefix."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
}
