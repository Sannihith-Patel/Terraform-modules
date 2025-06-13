output "vpc" {
  value = module.vpc.vpc_id
}

output "rds" {
  value = module.database.rds_endpoint
}
