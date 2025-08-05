output "current_environment" {
  value = terraform.workspace
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets."
  value       = module.network.subnet_ids
}

output "igw_id" {
  description = "The ID of the Internet Gateway."
  value       = module.network.igw_id
}

output "security_group_id" {
  description = "The ID of the environment-specific security group."
  value       = module.security.security_group_id
}

output "route_table_ids" {
  value       = module.network.route_table_ids
  description = "The IDs of the route tables."
}
