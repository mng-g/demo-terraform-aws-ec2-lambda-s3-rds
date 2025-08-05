output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "The IDs of the subnets."
  value       = [for s in aws_subnet.this : s.id]
}

output "igw_id" {
  description = "The ID of the Internet Gateway."
  value       = aws_internet_gateway.this.id
}

output "route_table_ids" {
  description = "The IDs of the route tables."
  value       = [aws_route_table.public_rt.id]
}
