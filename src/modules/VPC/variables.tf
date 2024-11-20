variable "region" {
  description = "AWS region"
  type        = string
}

variable "project-name" {
  description = "Project Name"
  type        = string
}
variable "env" {
  description = "Environment"
  type        = string
}

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


variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}