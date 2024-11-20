variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {}
variable "project_name" {}

#==================={VPC Module}========================
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

#===================={RDS Module}========================

variable "allocated_storage" {
  description = "The allocated storage in GB for the RDS instance."
  type        = number
}
variable "engine" {
  description = "The engine  to use for the RDS instance."
  type        = string
}
variable "engine_version" {
  description = "The engine version to use for the RDS instance."
  type        = string
}

variable "instance_class" {
  description = "The instance class to use for the RDS instance."
  type        = string
}

variable "identifier" {
    description = "The identifier to use for the RDS instance."
  type        = string
}
variable "db_name" {
  description = "The name of the DB."
  type        = string
}
variable "username" {
  description = "The master username for the RDS instance."
  type        = string
}

variable "password" {
  description = "The master password for the RDS instance."
  type        = string
  sensitive   = true
}

variable "port" {
  description = "The port on which the RDS instance will listen."
  type        = number
  default     = 5432
}

variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible."
  type        = bool
  default     = false
}


variable "final_snapshot_identifier" {
  description = "The name to use for the final snapshot."
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Whether the RDS instance should have a final snapshot"
  type        = bool
  default     = true
}
#=================================={ALB}==========================================

variable "internal" {
  description = "Whether the ALB should be internal."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create."
  type        = string
  default     = "application"
}


# Target Group Variables

variable "target_port" {
  description = "The port on which the target instances listen."
  type        = number
}

variable "target_protocol" {
  description = "The protocol used for communication with the target instances."
  type        = string
  default     = "HTTP"
}


variable "target_type" {
  description = "The type of target for the target group (e.g., instance, ip)."
  type        = string
  default     = "instance"
}

variable "deregistration_delay" {
  description = "The deregistration delay in seconds for unhealthy targets."
  type        = number
  default     = 300
}

variable "slow_start" {
  description = "The slow start duration in seconds for the target group."
  type        = number
  default     = 0
}

variable "health_check_path" {
  description = "The path to use for health checks against the target instances."
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "The protocol used for health checks (e.g., HTTP, HTTPS)."
  type        = string
  default     = "HTTP"
}

variable "health_check_interval" {
  description = "The interval in seconds between health checks."
  type        = number
  default     = 30
}

variable "matcher" {
  description = "HTTP matcher status code"
  type        = number
  default     = 200
}
variable "health_check_timeout" {
  description = "The timeout in seconds for health checks."
  type        = number
  default     = 5
}


variable "health_check_healthy_threshold" {
  description = "The number of successful health checks required to consider a target healthy."
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive failed health checks to consider a target unhealthy."
  type        = number
  default     = 2
}

# Listener Variables
variable "listener_port" {
  description = "The port on which the listener listens."
  type        = number
}

variable "listener_protocol" {
  description = "The protocol used for the listener (e.g., HTTP, HTTPS)."
  type        = string
  default     = "HTTP"
}

#==================================={EFS}======================================
variable "creation_token" {
  description = "A unique identifier to ensure idempotent creation."
  type        = string
}
variable "transition_to_ia" {
  description = "The number of days after which files are transitioned to the Infrequent Access (IA) storage class."
  type        = string
  default     = null
}


variable "access_points" {
  description = "A list of access points to create, with their root directory paths."
  type = map(object({
    path = string
  }))
  default = {}
}

#================================={ECS}===============================

variable "image_name" {
  description = "Image name for ECS" 
  type        = string
}

variable "container_port" {
  description = "container port for ECS" 
  type        = number
}
variable "host_port" {
  description = "host port for ECS" 
  type        = number
}
variable "network_mode" {
  description = "Network mode for ECS" 
  type        = string
}
variable "requires_compatibilities" {
  description = "requires_compatibilities for ECS"
  type = list(string)
}
variable "memory" {
  description = "Memory for ECS" 
  type        = string
}
variable "cpu" {
  description = "cpu for ECS" 
  type        = string
}



variable "mount_points" {
  type = list(object({
    sourceVolume = string
    containerPath = string
    readOnly = bool
  }))
}

variable "desired_count" {
  description = "Desired number service for ECS" 
  type        = number
}

variable "scheduling_strategy" {
  description = "scheduling_strategy service for ECS" 
  type        = string
}

variable "max_capacity" {
   description = "Max  number of service for ECS" 
  type        = number
}
variable "min_capacity" {
   description = "Min  number of service for ECS" 
  type        = number
}