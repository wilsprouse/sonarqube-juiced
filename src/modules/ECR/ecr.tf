resource "aws_ecr_repository" "aws-ecr" {
  name = "${var.project-name}-ecr"
  tags = {
    Name        = "${var.project-name}-ecr"
    Environment = "${var.env}"
  }
}