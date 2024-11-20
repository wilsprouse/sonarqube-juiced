variable "project-name" {}
variable "env" {}

variable "db_subnet_id" {
  type = list(string)
  description = "VPC list of Subnet IDs for the database"
}
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


variable "vpc_security_group_ids" {
  description = "The IDs of the VPC security groups to associate with the RDS instance."
  type        = list(string)
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
