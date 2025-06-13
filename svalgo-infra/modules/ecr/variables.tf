variable "ecr_repo" {
  type = string
}

variable "mutability" {
  type    = string
  default = "IMMUTABLE"
}

variable "image_scan" {
  type    = bool
  default = true
}