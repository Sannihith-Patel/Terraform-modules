resource "aws_db_instance" "database" {
  depends_on                  = [aws_db_subnet_group.mysql_subnetgroup]
  identifier                  = "${var.db_identifier}-${var.unique_string}"
  allocated_storage           = var.storage
  db_name                     = var.db_name
  engine                      = var.db_engine
  engine_version              = var.db_engine_version
  instance_class              = var.db_instance_class
  username                    = var.db_username
  multi_az                    = var.db_multi_az
  manage_master_user_password = var.manage_master_user_password
  parameter_group_name        = aws_db_parameter_group.db_parameter_group.name
  db_subnet_group_name        = aws_db_subnet_group.mysql_subnetgroup.name
  skip_final_snapshot         = var.skip_final_snapshot
  #final_snapshot_identifier   = "${var.db_identifier}-${local.timestamp_sanitized}"
  auto_minor_version_upgrade = true
  backup_retention_period    = var.backup_retention
  copy_tags_to_snapshot      = true
  vpc_security_group_ids     = var.db_security_groups
  monitoring_interval        = var.db_monitoring_interval
  deletion_protection        = var.deletion_protection
  storage_encrypted          = var.storage_encrypted
  tags = merge(
    { Name = "${var.db_identifier}-${var.unique_string}" },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      engine_version,
      monitoring_interval,
      instance_class
    ]
  }
}