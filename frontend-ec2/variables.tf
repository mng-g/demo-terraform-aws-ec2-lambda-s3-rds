variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "prefix" {
  type        = string
  default     = "terraform-nginx"
  description = "Prefix for the resources"
}

variable "ami" {
  type        = string
  default     = "ami-0150ccaf51ab55a51" # This is a commonly used Amazon Linux 2 AMI (update based on your region)
  description = "AMI to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro" # Free Tier eligible
  description = "Instance type for the EC2 instance"
}