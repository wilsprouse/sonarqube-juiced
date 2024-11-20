resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                    = "${var.project-name}-task-definition"
  execution_role_arn        = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode              = var.network_mode
  requires_compatibilities  = var.requires_compatibilities
  cpu                       = var.cpu
  memory                    = var.memory

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions     = jsonencode([
    {
      name                  = "${var.project-name}-container"
      image                 = var.image_name
      essential             = true
      portMappings          = [
        {
          name              = "${var.project-name}-${var.container_port}-tcp"
          containerPort     = var.container_port
          hostPort          = var.host_port
        }
      ]
      environment           = var.environment_variables
      ulimits = [
        {
          name = "nofile",
          softLimit = 65535,
          hardLimit = 65535
        }
      ]
      mountPoints = var.mount_points
      logConfiguration = {
        logDriver   = "awslogs",
        options     = {
          "awslogs-group"          = aws_cloudwatch_log_group.log_group.name,
           "awslogs-region"        = var.region,
          "awslogs-stream-prefix"  = "${var.project-name}"
        }
      }
    }
  ])

dynamic "volume" {
    for_each = var.volumes
    content {
      name = volume.value.name

      efs_volume_configuration {
        file_system_id       = volume.value.efs_volume_configuration.file_system_id
        root_directory       = volume.value.efs_volume_configuration.root_directory
        transit_encryption   = volume.value.efs_volume_configuration.transit_encryption

        authorization_config {
          access_point_id = volume.value.efs_volume_configuration.authorization_config.access_point_id
          iam             = volume.value.efs_volume_configuration.authorization_config.iam
        }
      }
    }
  }



    tags = {
    Name        = "${var.project-name}-ecs-td"
    Environment = var.env
  }

}
