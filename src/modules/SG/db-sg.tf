  resource "aws_security_group" "rds_security_group" {
  name        = "${var.project-name}-rds-sg"
  description = "enable rds access on port  5432"
  vpc_id      =  var.vpc_id

  ingress {
    description      = "rds access"
    from_port = 5432
    to_port   = 5432
    protocol = "tcp"
    security_groups  = [aws_security_group.ecs_security_group.id]
 }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project-name}-rds-sg"
    Environment = var.env
  }
}