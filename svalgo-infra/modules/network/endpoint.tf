resource "aws_vpc_endpoint" "ecr-api" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.ecs_endpoint_sg.id
  ]
  subnet_ids = aws_subnet.private_subnets[*].id
  tags = merge(
    { Name = "${var.vpc_name}-ecr-api-endpoint-${var.unique_string}" },
    var.tags
  )
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.ecs_endpoint_sg.id
  ]
  subnet_ids = aws_subnet.private_subnets[*].id
  tags = merge(
    { Name = "${var.vpc_name}-ecr-dkr-endpoint-${var.unique_string}" },
    var.tags
  )
}