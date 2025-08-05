variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of subnet CIDR blocks (must be 2 for RDS Free Tier)"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones (must be 2 for RDS Free Tier)"
  type        = list(string)
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)"
  type        = string
}
