resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.ecs_cluster_name}-${var.unique_string}"

  tags = merge(
    { Name = "${var.ecs_cluster_name}" },
    var.tags
  )
}