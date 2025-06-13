resource "aws_ecs_service" "ecs_service" {
  name            = "${var.app_name}-service-${var.unique_string}"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = concat([aws_security_group.ecs_app_sg.id], [var.ecs_endpoint_sg])
  }

  force_new_deployment = true
  launch_type          = "FARGATE"
  # triggers = {
  #   redeployment = aws_ecs_task_definition.ecs_task_definition.revision
  # }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = var.app_name
    container_port   = var.containerport
  }
  tags = merge(
    { Name = "${var.app_name}-service-${var.unique_string}" },
    var.tags
  )
}