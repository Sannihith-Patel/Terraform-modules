resource "aws_security_group" "ecs_app_sg" {
  vpc_id                 = var.vpc_id
  name                   = "${var.app_name}-ecs-sg-${var.unique_string}"
  description            = "Security group for alb"
  revoke_rules_on_delete = true
  tags = merge(
    { Name = "${var.app_name}-ecs-sg-${var.unique_string}" },
    var.tags
  )
}

resource "aws_security_group_rule" "ecs_app_sg_ingress" {
  type              = "ingress"
  from_port         = var.containerport
  to_port           = var.containerport
  protocol          = "TCP"
  description       = "Allow http inbound traffic from internet"
  security_group_id = aws_security_group.ecs_app_sg.id
  #cidr_blocks       = ["0.0.0.0/0"]
  source_security_group_id = var.source_security_group_id
}

resource "aws_security_group_rule" "ecs_app_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from alb"
  security_group_id = aws_security_group.ecs_app_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_security_group_rule" "external_alb_ingress" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "TCP"
#   description       = "Allow https inbound traffic from internet"
#   security_group_id = aws_security_group.ecs_app_sg.id
#   source_security_group_id       = var.external_alb_sg
# }