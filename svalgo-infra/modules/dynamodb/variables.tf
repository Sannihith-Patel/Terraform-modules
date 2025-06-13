variable "table_name" {
  type = string
}

variable "hash_key" {
  type = string
}

variable "pitr" {
  type    = bool
  default = false
}

variable "billing_mode" {
  type = string
}

variable "hash_key_datatype" {
  type = string
}

variable "ttl_attribute_name" {
  type    = string
  default = ""
}

variable "ttl_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "deletion_protection_enabled" {
  type    = bool
  default = false
}

variable "server_side_encryption" {
  type    = bool
  default = true
}

variable "table_class" {
  type    = string
  default = "STANDARD"
}

variable "unique_string" {
  type = string
}

variable "range_key" {
  type = string
}

variable "range_key_datatype" {
  type = string
}

variable "range_key_exists" {
  type    = bool
  default = true
}

variable "environment" {
  type = string
}