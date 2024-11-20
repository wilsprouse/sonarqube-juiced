# resource "random_password" "password" {
#   length           = 16
#   special          = false
#   override_special = "!#$%&*()-_=+[]{}<>:?"
# }

resource "aws_db_subnet_group" "sub-grp" {
  name       = "${var.project-name}-sub-grp"
  subnet_ids =  var.db_subnet_id

  tags = {
    Name = "${var.project-name} subnet group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = var.identifier 
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  port                    = var.port
  publicly_accessible     = var.publicly_accessible
  db_subnet_group_name    = aws_db_subnet_group.sub-grp.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot       = var.skip_final_snapshot

}
