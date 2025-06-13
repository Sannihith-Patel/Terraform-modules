variable "filename" {
  type = string
}

variable "function_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "unique_string" {
  type = string
}

variable "lambda_handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "lambda_layers" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "code_bucket" {
  type = string
}