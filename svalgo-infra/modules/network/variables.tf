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

variable "db_security_group" {
  type    = string
  default = "mysql"
}

variable "external_alb_sg" {
  type = string
}

variable "internal_alb_sg" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "unique_string" {
  type = string
}

variable "region" {
  type = string
}

variable "ssl_cert_arn" {
  type = string
}

variable "ui_alb_sg" {
  type = string
}