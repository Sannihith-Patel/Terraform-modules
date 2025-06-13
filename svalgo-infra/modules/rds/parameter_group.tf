resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "${var.db_identifier}-pg"
  family = var.pg_family

  tags = merge(
    { Name = "${var.db_identifier}-pg-${var.unique_string}" },
    var.tags
  )
}