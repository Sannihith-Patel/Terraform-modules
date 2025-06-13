resource "aws_db_subnet_group" "mysql_subnetgroup" {
  name       = "${var.db_identifier}-subnetgroup--${var.unique_string}"
  subnet_ids = var.db_subnets

  tags = merge({
    Name = "${var.db_identifier}-subnetgroup--${var.unique_string}" },
    var.tags
  )
}