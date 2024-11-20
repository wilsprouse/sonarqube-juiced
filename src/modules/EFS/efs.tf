resource "aws_efs_file_system" "efs" {
  creation_token = var.creation_token

  performance_mode = var.performance_mode


  throughput_mode = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps

  encrypted = var.encrypted
  kms_key_id = var.kms_key_id

  lifecycle_policy {
    transition_to_ia = var.transition_to_ia
  }
availability_zone_name = var.availability_zone

  tags = {
    Name        = "${var.project-name}-efs"
    Environment = var.env
  }
}

resource "aws_efs_mount_target" "mount_target" {

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

}

resource "aws_efs_access_point" "access_point" {
  for_each = var.access_points

  file_system_id = aws_efs_file_system.efs.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = each.value.path
    creation_info {
      owner_gid = 1000
      owner_uid = 1000
      permissions = "755"
    }
  }
}