output "id" {
  value = aws_efs_file_system.efs.id
}

output "dns_name" {
  value = aws_efs_file_system.efs.dns_name
}

output "access_points_ids" {
  value = [for access_point in aws_efs_access_point.access_point : access_point.id]
}
