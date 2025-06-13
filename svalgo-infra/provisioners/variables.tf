variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "databse_name" {
  type = string
}

variable "database_identifier" {
  type = string
}

variable "billing_mode" {
  type = string
}

variable "hash_key" {
  type = string
}

variable "hash_key_datatype" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "ssl_cert_arn" {
  type = string
}