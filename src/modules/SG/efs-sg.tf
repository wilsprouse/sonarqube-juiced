resource "aws_security_group" "efs_security_group" {
  vpc_id =  var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name        = "${var.project-name}-efs-sg"
    Environment = var.env
  }
}

# resource "aws_security_group" "efs_security_group" {
#   name        = "${var.project-name}-efs-sg"
#   description = "Security group for EFS mount target"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port                = 2049
#     to_port                  = 2049
#     protocol                 = "tcp"
#     description              = "ECS container to NFS port"
#     cidr_blocks              = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#     tags = {
#     Name        = "${var.project-name}-efs-sg"
#     Environment = var.env
#   }
# }
