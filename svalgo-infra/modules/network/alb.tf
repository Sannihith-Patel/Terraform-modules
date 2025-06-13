resource "aws_lb" "external_alb" {
  name               = "${var.vpc_name}-external-alb-${var.unique_string}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.external_alb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id
  tags = merge(
    { Name = "${var.vpc_name}-external-alb-${var.unique_string}",
    alb_type = "External" },
    var.tags
  )
}
resource "aws_lb" "ui_alb" {
  name               = "${var.vpc_name}-ui-alb-${var.unique_string}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ui_alb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id
  tags = merge(
    { Name = "${var.vpc_name}-ui-alb-${var.unique_string}",
    alb_type = "Ui" },
    var.tags
  )
}

resource "aws_lb" "internal_alb" {
  name               = "${var.vpc_name}-internal-alb-${var.unique_string}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_alb_sg.id]
  subnets            = aws_subnet.private_subnets[*].id
  tags = merge(
    { Name = "${var.vpc_name}-internal-alb-${var.unique_string}",
    alb_type = "Internal" },
    var.tags
  )
}

resource "aws_alb_listener" "external_alb_listener" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.ssl_cert_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "No matching application found."
      status_code  = "404"
    }
  }
}

resource "aws_alb_listener" "ui_alb_listener" {
  load_balancer_arn = aws_lb.ui_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.ssl_cert_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "No matching application found."
      status_code  = "404"
    }
  }
}

resource "aws_alb_listener" "internal_alb_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.ssl_cert_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "No matching application found."
      status_code  = "404"
    }
  }
}