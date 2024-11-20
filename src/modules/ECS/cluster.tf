resource "aws_ecs_cluster" "aws_ecs_cluster" {
  name = "${var.project-name}-cluster"
  tags = {
    Name        = "${var.project-name}-ecs"
    Environment = var.env
  }
}
