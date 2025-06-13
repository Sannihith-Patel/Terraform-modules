variable "fargate_cpu" {
  type = number
}

variable "fargate_memory" {
  type = number
}

variable "app_name" {
  type = string
}

variable "ecs_cluster_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "containerport" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "alb_arn" {
  type = string
}

variable "alb_sg" {
  type = string
}
variable "tags" {
  type = map(string)
}

variable "domain_name" {
  type = string
}

variable "image" {
  type = string
}

variable "aws_account" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ecr_repo" {
  type = string
}

variable "environment" {
  type = string
}
variable "ecs_endpoint_sg" {
  type = string
}

variable "unique_string" {
  type = string
}

variable "default_tg" {
  type = bool
}

variable "alb_listener" {
  type = string
}

variable "path_pattern" {
  type = string
}
variable "priority" {
  type = number
}

variable "apptype" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "external_alb_sg" {
  type = string
}

variable "internal_alb_sg" {
  type = string
}

variable "ui_alb_sg" {
  type = string
}

variable "source_security_group_id" {
  type = string
}