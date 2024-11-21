#==================={GLOBAL}====================

region = "us-east-1"
environment    = "production"
project_name = "sonarqube"

#====================={VPC}======================

  vpc_cidr_block = "10.0.0.0/16"
  public_subnet_cidr_blocks = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]

  private_subnet_cidr_blocks = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
  ]

#========================{RDS}===============================
  
  identifier              = "sonarqube-postgres-instance"
  allocated_storage       =  "60"
  engine                  = "postgres"
  engine_version          = "15"
  instance_class          = "db.t3.medium"
  db_name                 = "sonarqube"
  username                = "sonarqube"
  password                = "sonarqube"
  port                    = 5432
  publicly_accessible     = false
  final_snapshot_identifier ="sonarqube-final-snapshot-identifier"
  skip_final_snapshot       = true

#=========================={ALB}=================================

  target_port             = 80
  listener_port           = 80
  target_type             = "ip"

#=========================={EFS}=================================

  creation_token              = "sonarqube-efs"
  transition_to_ia            = "AFTER_7_DAYS"
  access_points = {
    "sonarqube_data" = {
      path = "/sonarqube_data"
    }
    "sonarqube_logs" = {
      path = "/sonarqube_logs"
    }
    "sonarqube_extensions" = {
      path = "/sonarqube_extensions"
    }
  }

#============================={ECS}==============================
  
  requires_compatibilities    = ["FARGATE"]
  network_mode                = "awsvpc"
  image_name                  = "sonarqube:lts-community"
  host_port                   = "9000"
  container_port              = "9000"
  memory                      =  3072
  cpu                         =  1024
  desired_count               =    1
  min_capacity                =    1
  max_capacity                =    2
  scheduling_strategy         = "REPLICA" 
  mount_points = [ 
    {
      "sourceVolume":"sonarqube_data",
      "containerPath":"/opt/sonarqube/data",
      "readOnly":false
    },
    {
      "sourceVolume":"sonarqube_extensions",
      "containerPath":"/opt/sonarqube/extensions",
      "readOnly":false
    },
    {
      "sourceVolume":"sonarqube_logs",
      "containerPath":"/opt/sonarqube/logs",
      "readOnly":false
    }    
  ]

#================================================================
