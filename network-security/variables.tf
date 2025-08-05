variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "azs" {
  description = "List of availability zones for public subnets (must be 2 for RDS Free Tier)"
  type        = list(string)
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "subnet_cidrs" {
  description = "List of subnet CIDR blocks for public subnets (must be 2 for RDS Free Tier)"
  type        = list(string)
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}