
output "alb_security_group" {
  value = aws_security_group.alb_security_group.id
}

output "ecs_security_group" {
  value = aws_security_group.ecs_security_group.id
}

output "rds_security_group" {
  value = aws_security_group.rds_security_group.id
}

output "efs_security_group" {
  value = aws_security_group.efs_security_group.id
}