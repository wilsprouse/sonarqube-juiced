variable "project-name" {}
variable "env" {}

# variable "name" {
#   description = "The name of the EFS file system."
#   type        = string
# }

variable "creation_token" {
  description = "A unique identifier to ensure idempotent creation."
  type        = string
}

variable "performance_mode" {
  description = "The performance mode of the file system."
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "The throughput mode of the file system."
  type        = string
  default     = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  description = "The provisioned throughput in MiB/s for the file system."
  type        = number
  default     = null
}

variable "encrypted" {
  description = "Whether to encrypt the file system at rest."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN of the KMS key to use for encryption."
  type        = string
  default     = null
}

variable "transition_to_ia" {
  description = "The number of days after which files are transitioned to the Infrequent Access (IA) storage class."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "The AZ for one AZ deployment"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to create the mount target in."
  type        = string
}

variable "security_groups" {
  description = "The IDs of the security groups to associate with the mount target."
  type        = list(string)
}

variable "access_points" {
  description = "A list of access points to create, with their root directory paths."
  type = map(object({
    path = string
  }))
  default = {}
}

