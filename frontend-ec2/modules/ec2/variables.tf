variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)"
  type        = string
}

variable "iam_instance_profile" {
  description = "Name of the IAM instance profile to attach to EC2 (optional)."
  type        = string
  default     = null
}

variable "index_html_template" {
  description = "Path to the index.html.tpl file to be served by NGINX"
  type        = string  
}

variable "api_url" {
  description = "API URL"
  type        = string
}

variable "script_js_path" {
  description = "Path to the script.js file to be served by NGINX"
  type        = string
}