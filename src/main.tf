data "aws_availability_zones" "available" {}
provider "aws" {
  region = var.region
 
  default_tags {
      tags = {
      Environment = var.environment
      }
    }
}

module "vpc" {
  source = "./modules/VPC"
  project-name                = var.project_name
  env                         = var.environment
  region                      = var.region
  vpc_cidr_block              = var.vpc_cidr_block
  public_subnet_cidr_blocks   = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks  = var.private_subnet_cidr_blocks
  availability_zones          = data.aws_availability_zones.available.names

}

module "sg" {
  source = "./modules/SG"
  vpc_id  = module.vpc.vpc_id
  project-name                = var.project_name
  env                         = var.environment
  vpc_cidr_block              = module.vpc.vpc_cidr_block
}


module "rds" {
  source = "./modules/RDS"
  project-name            = var.project_name
  env                     = var.environment
  identifier              = var.identifier 
  db_subnet_id            = module.vpc.private_subnet_ids
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  port                    = var.port
  publicly_accessible     = var.publicly_accessible
  vpc_security_group_ids  = [module.sg.rds_security_group]
  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot       = var.skip_final_snapshot
}

module "alb" {
  source = "./modules/ALB"
  project-name            = var.project_name
  env                     = var.environment
  security_group_ids      = [module.sg.alb_security_group]
  vpc_id                  = module.vpc.vpc_id
  target_port             = var.target_port
  subnet_ids              = module.vpc.public_subnet_ids
  listener_port           = var.listener_port 
  target_type             = var.target_type 
}


module "efs" {
 source = "./modules/EFS"
  project-name                = var.project_name
  env                         = var.environment
  creation_token              = var.creation_token
  transition_to_ia            = var.transition_to_ia
  availability_zone           = element(data.aws_availability_zones.available.names, 0)
  subnet_id                   = element(module.vpc.private_subnet_ids, 0)
  security_groups             = [module.sg.efs_security_group]
  access_points               = var.access_points

}
module "ecr" {
  source = "./modules/ECR"
  project-name                = var.project_name
  env                         = var.environment
}

module "ecs" {
  source    = "./modules/ECS"
  project-name                = var.project_name
  env                         = var.environment
  region                      = var.region
  requires_compatibilities    = var.requires_compatibilities
  network_mode                = var.network_mode
  image_name                  = var.image_name
  host_port                   = var.host_port
  container_port              = var.container_port
  subnet_ids                  = module.vpc.private_subnet_ids
  security_groups_id          = [module.sg.ecs_security_group]
  memory                      = var.memory
  cpu                         = var.cpu
  scheduling_strategy         = var.scheduling_strategy
  desired_count               = var.desired_count
  target_group_arn            = module.alb.target_group_arn 
  min_capacity                = var.min_capacity
  max_capacity                = var.max_capacity
  volumes                     = [
     {
      name = "sonarqube_data"
      efs_volume_configuration = {
        file_system_id     = module.efs.id
        root_directory     = "/"
        transit_encryption = "ENABLED"
        authorization_config = {
          access_point_id =  module.efs.access_points_ids[0]
          iam             = "DISABLED"
        }
      }
    },
    {
      name = "sonarqube_extensions"
      efs_volume_configuration = {
        file_system_id     = module.efs.id
        root_directory     = "/"
        transit_encryption = "ENABLED"
        authorization_config = {
          access_point_id =  module.efs.access_points_ids[1]
          iam             = "DISABLED"
        }
      }
    },
    {
      name = "sonarqube_logs"
      efs_volume_configuration = {
        file_system_id     = module.efs.id
        root_directory     = "/"
        transit_encryption = "ENABLED"
        authorization_config = {
          access_point_id =  module.efs.access_points_ids[2]
          iam             = "DISABLED"
        }
      }
    },
  ]
  mount_points                = var.mount_points

  environment_variables       = [
    {
      "name" : "SONAR_JDBC_URL",
      "value":"jdbc:postgresql://${module.rds.endpoint}/sonarqube"
    },
    {
      "name" : "SONAR_JDBC_USERNAME",
      "value":"${module.rds.username}"
    },
    {
      "name" : "SONAR_JDBC_PASSWORD",
      "value":"${module.rds.password}"
    },
    {
      "name" : "SONAR_SEARCH_JAVAADDITIONALOPTS",
      "value":"-Dnode.store.allow_mmap=false,-Ddiscovery.type=single-node"
    }
  ]

}