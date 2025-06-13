vpc_name             = "blue"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
environment          = "blue"
databse_name         = "dev"
database_identifier  = "algocore"
billing_mode         = "PAY_PER_REQUEST"
hash_key             = "tenant_id"
hash_key_datatype    = "S"
ecs_cluster_name     = "tfalgo"
domain_name          = "test.com"
ssl_cert_arn         = "arn:aws:acm:ap-south-1:897722692373:certificate/785f89af-f345-4d7e-83b3-07c5432b3b51"
tags = {
  "Environment" = "blue"
}