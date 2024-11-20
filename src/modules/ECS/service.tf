resource "aws_ecs_service" "ecs_service" {
  name              = "${var.project-name}-service"
  launch_type       = "FARGATE"
  cluster           = aws_ecs_cluster.aws_ecs_cluster.id
  task_definition   = aws_ecs_task_definition.ecs_task_definition.arn
  platform_version  = "LATEST"
  desired_count     = var.desired_count
  scheduling_strategy  = var.scheduling_strategy
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  # task tagging configuration
  enable_ecs_managed_tags            = false
  propagate_tags                     = "SERVICE"

  # vpc and security groups
  network_configuration {
    subnets                 = var.subnet_ids
    security_groups         = var.security_groups_id
    assign_public_ip        = false
  }

  # load balancing
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.project-name}-container"
    container_port   = var.container_port
  }

    tags = {
    Name        = "${var.project-name}-ecs-service"
    Environment = var.env
  }
}