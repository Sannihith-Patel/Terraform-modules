resource "aws_lb_listener_rule" "alb_listener_rule" {
  listener_arn = var.alb_listener
  priority     = var.priority
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
  condition {
    path_pattern {
      values = ["/${var.path_pattern}/*"]
    }
  }
}

