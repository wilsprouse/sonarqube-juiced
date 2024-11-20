variable "project-name" {}
variable "env" {}


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

variable "subnet_ids" {
  description = "The IDs of the subnets to attach the ALB to."
  type        = list(string)
}

variable "security_group_ids" {
  description = "The IDs of the security groups to assign to the ALB."
  type        = list(string)
}

# Target Group Variables
# variable "target_group_name" {
#   description = "The name of the target group."
#   type        = string
# }

variable "target_port" {
  description = "The port on which the target instances listen."
  type        = number
}

variable "target_protocol" {
  description = "The protocol used for communication with the target instances."
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "The ID of the VPC containing the ALB and target instances."
  type        = string
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

