output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "database_sg" {
  value = aws_security_group.database_sg.id
}

output "ecs_endpoint_sg" {
  value = aws_security_group.ecs_endpoint_sg.id
}

output "external_alb_arn" {
  value = aws_lb.external_alb.arn
}


output "ui_alb_arn" {
  value = aws_lb.ui_alb.arn
}
output "internal_alb_arn" {
  value = aws_lb.internal_alb.arn
}

output "external_alb_sg" {
  value = aws_security_group.external_alb_sg.id
}

output "ui_alb_sg" {
  value = aws_security_group.ui_alb_sg.id
}

output "internal_alb_sg" {
  value = aws_security_group.internal_alb_sg.id
}

output "external_alb_listener" {
  value = aws_alb_listener.external_alb_listener.arn
}

output "internal_alb_listener" {
  value = aws_alb_listener.internal_alb_listener.arn
}

output "ui_alb_listener" {
  value = aws_alb_listener.ui_alb_listener.arn
}
