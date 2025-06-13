# resource "aws_security_group_rule" "alb_http_ingress" {
#   type              = "ingress"
#   from_port         = var.containerport
#   to_port           = var.containerport
#   protocol          = "TCP"
#   description       = "Allow https inbound traffic from internet"
#   security_group_id = var.alb_sg
#   cidr_blocks       = ["0.0.0.0/0"]
# }
