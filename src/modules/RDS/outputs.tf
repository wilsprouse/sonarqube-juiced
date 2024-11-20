output "endpoint" {
  value       = aws_db_instance.postgres.endpoint
  description = "The endpoint of the RDS instance."
}

output "password" {
  value       = aws_db_instance.postgres.password
  sensitive   = true
  description = "The password for the RDS instance."
}

output "username" {
  value       = aws_db_instance.postgres.username
  sensitive   = true
  description = "The password for the RDS instance."
}
