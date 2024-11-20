resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.project-name}-logs"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Application = var.project-name
    Environment = var.env
  }
}

