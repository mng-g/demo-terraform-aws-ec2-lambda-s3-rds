output "security_group_id" {
  description = "The ID of the environment-specific security group."
  value       = aws_security_group.allow_http.id
}
