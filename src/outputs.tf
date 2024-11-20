#============================={ALB}=====================================
# output "arn" {
#   value = module.alb.arn
# }

output "dns_name" {
  value = module.alb.dns_name
}
#============================{RDS}=======================
output "sonarqube_db_endpoint" {
  value = module.rds.endpoint
}