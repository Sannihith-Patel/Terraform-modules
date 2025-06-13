resource "aws_dynamodb_table" "dynamo" {
  name        = var.table_name
  table_class = var.table_class
  hash_key    = var.hash_key
  range_key   = var.range_key
  # dynamic "range_key" {
  #   for_each = var.range_key_exists ? [1] : []
  #   content{
  #     range_key =var.range_key
  #   }
  # }
  deletion_protection_enabled = var.deletion_protection_enabled
  server_side_encryption {
    enabled = var.server_side_encryption
  }
  point_in_time_recovery {
    enabled = var.pitr
  }
  billing_mode = var.billing_mode
  attribute {
    name = var.hash_key
    type = var.hash_key_datatype
  }
  dynamic "attribute" {
    # This block will be created only if var.range_key_exists is true
    for_each = var.range_key_exists ? [1] : [] # Iterate once if true, zero times if false

    content {
      name = var.range_key
      type = var.range_key_datatype
    }
  }
  ttl {
    attribute_name = var.ttl_attribute_name
    enabled        = var.ttl_enabled
  }
  tags = merge(
    { Name = "${var.table_name}" },
    var.tags
  )
}

# resource "aws_dynamodb_table" "dynamodb" {
#   count = var.range_key_exists ? 0 : 1
#   name                        = "${var.table_name}-${var.unique_string}"
#   table_class                 = var.table_class
#   hash_key                    = var.hash_key
#   deletion_protection_enabled = var.deletion_protection_enabled
#   server_side_encryption {
#     enabled = var.server_side_encryption
#   }
#   point_in_time_recovery {
#     enabled = var.pitr
#   }
#   billing_mode = var.billing_mode
#   attribute {
#     name = var.hash_key
#     type = var.hash_key_datatype
#   }
#   ttl {
#     attribute_name = var.ttl_attribute_name
#     enabled        = var.ttl_enabled
#   }
#   tags = merge(
#     { Name = "${var.table_name}" },
#     var.tags
#   )
# }