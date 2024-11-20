resource "aws_alb" "application_load_balancer" {
  name               = "${var.project-name}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids
  tags = {
    Name        = "${var.project-name}-alb"
    Environment = var.env
  }
}


resource "aws_lb_target_group" "target_group" {
  name     = "${var.project-name}-tg"
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id
  target_type = var.target_type

  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    matcher             = var.matcher 
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = {
    Name        = "${var.project-name}-lb-tg"
    Environment = var.env
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = {
    Name        = "${var.project-name}-lb-listener"
    Environment = var.env
  }
}