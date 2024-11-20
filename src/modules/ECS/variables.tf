variable "project-name" {}
variable "env" {}
variable "region" {}

variable "subnet_ids" {
  description = "Subnet ids for ECS"
  type        = list(string)
} 


variable "security_groups_id" {
  description = "Security group ids for ECS"
  type        = list(string)
} 

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

variable "environment_variables" {
  type = list(object({
    name = string
    value = string
  }))
}
# variable "healthCheck" {
#   type = object({
#     retries = number
#     command     = list(string)
#     timeout     =  number
#     interval    =  number
#     startPeriod =  number
#   })
# }
variable "mount_points" {
  type = list(object({
    sourceVolume = string
    containerPath = string
    readOnly = bool
  }))
}
variable "volumes" {
  type = list(object({
    name                   = string
    efs_volume_configuration = object({
      file_system_id     = string
      root_directory     = string
      transit_encryption = string
      authorization_config = object({
        access_point_id = string
        iam             = string
      })
    })
  }))
}

variable "target_group_arn" {
  description = "ALB target_group_arn"
  type = string
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