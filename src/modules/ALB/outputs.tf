output "arn" {
  value = aws_alb.application_load_balancer.arn
}

output "dns_name" {
  value = aws_alb.application_load_balancer.dns_name
}
output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}