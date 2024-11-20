resource "aws_security_group" "ecs_security_group" {
  name        =  "${var.project-name}-ecs-sg"
  description = "Security group for ECS Fargate"
  vpc_id      =  var.vpc_id

  ingress {
    description      = "http access"
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description      = "EFS access"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project-name}-ecs-sg"
    Environment = var.env
  }

}