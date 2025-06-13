resource "aws_security_group" "database_sg" {
  name        = var.db_security_group
  description = "Allow access to datbase"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    { Name = "SG-${var.db_security_group}-${var.unique_string}",
    vpc = aws_vpc.vpc.id },
    var.tags
  )
}

resource "aws_security_group" "external_alb_sg" {
  vpc_id                 = aws_vpc.vpc.id
  name                   = var.external_alb_sg
  description            = "Security group for external alb"
  revoke_rules_on_delete = true
  tags = merge(
    { Name = "SG-${var.external_alb_sg}-${var.unique_string}",
    vpc = aws_vpc.vpc.id },
    var.tags
  )
}

resource "aws_security_group" "ui_alb_sg" {
  vpc_id                 = aws_vpc.vpc.id
  name                   = var.ui_alb_sg
  description            = "Security group for external alb"
  revoke_rules_on_delete = true
  tags = merge(
    { Name = "SG-${var.ui_alb_sg}-${var.unique_string}",
    vpc = aws_vpc.vpc.id },
    var.tags
  )
}

resource "aws_security_group" "internal_alb_sg" {
  vpc_id                 = aws_vpc.vpc.id
  name                   = var.internal_alb_sg
  description            = "Security group for internal alb"
  revoke_rules_on_delete = true
  tags = merge(
    { Name = "SG-${var.internal_alb_sg}-${var.unique_string}",
    vpc = aws_vpc.vpc.id },
    var.tags
  )
}

resource "aws_security_group_rule" "external_alb_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  description       = "Allow https inbound traffic from internet"
  security_group_id = aws_security_group.external_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "ui_alb_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  description       = "Allow https inbound traffic from internet"
  security_group_id = aws_security_group.ui_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internal_alb_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  description       = "Allow https inbound traffic from internet"
  security_group_id = aws_security_group.internal_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "external_alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from extranl alb"
  security_group_id = aws_security_group.external_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ui_alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from extranl alb"
  security_group_id = aws_security_group.ui_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internal_alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from internal alb"
  security_group_id = aws_security_group.internal_alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "ecs_endpoint_sg" {
  vpc_id                 = aws_vpc.vpc.id
  name                   = "${var.vpc_name}-ecs-endpoint-sg"
  description            = "Security group for ecs endpoint"
  revoke_rules_on_delete = true
}

resource "aws_security_group_rule" "ecs_endpoint_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  description       = "Allow https inbound traffic from internet"
  security_group_id = aws_security_group.ecs_endpoint_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ecs_endpoint_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from alb"
  security_group_id = aws_security_group.ecs_endpoint_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}