resource "aws_lb_target_group" "app_tg" {
  name        = "${var.app_name}-tg-${var.unique_string}"
  port        = var.containerport
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/${var.path_pattern}/"
    protocol            = "HTTP"
    matcher             = "200"
    port                = var.containerport
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 20
  }
  tags = merge(
    { Name = "${var.app_name}-tg-${var.unique_string}" },
    var.tags
  )
}
