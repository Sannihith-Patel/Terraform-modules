resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.ecr_repo
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = var.image_scan
  }
}