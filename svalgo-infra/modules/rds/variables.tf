variable "db_name" {
  type = string
}
variable "storage" {
  type    = number
  default = 20
}
variable "db_engine" {
  type    = string
  default = "mysql"
}
variable "db_engine_version" {
  type    = string
  default = "8.0"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "db_username" {
  type    = string
  default = "dbuser"
}

variable "db_identifier" {
  type = string
}

variable "db_multi_az" {
  type    = bool
  default = true
}

variable "db_security_groups" {
  type = list(string)
}
variable "db_monitoring_interval" {
  type    = number
  default = 0
}

variable "tags" {
  type = map(string)
}

variable "manage_master_user_password" {
  type    = bool
  default = true
}

variable "pg_family" {
  type    = string
  default = "mysql8.0"
}

variable "backup_retention" {
  type    = number
  default = 0
}

variable "db_subnets" {
  type = list(any)
}
variable "deletion_protection" {
  type    = bool
  default = false
}
variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "unique_string" {
  type = string
}
