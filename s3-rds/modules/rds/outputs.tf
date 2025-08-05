output "endpoint" {
  description = "The endpoint of the RDS instance."
  value       = aws_db_instance.this.address
}

output "db_name" {
  description = "The database name."
  value       = aws_db_instance.this.db_name
}

output "username" {
  description = "The master username for the database."
  value       = aws_db_instance.this.username
}


