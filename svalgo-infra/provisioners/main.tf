module "vpc" {
  source               = "../modules/network"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  external_alb_sg      = "${var.vpc_name}-external-alb-sg"
  internal_alb_sg      = "${var.vpc_name}-internal-alb-sg"
  ui_alb_sg            = "${var.vpc_name}-ui-alb-sg"
  unique_string        = local.unique_string
  region               = local.unique_string
  ssl_cert_arn         = var.ssl_cert_arn
  tags = merge(
    var.tags,
    local.common_tags,
    { unique_string = local.unique_string }
  )
}

module "database" {
  source             = "../modules/rds"
  depends_on         = [module.vpc]
  db_name            = var.databse_name
  db_identifier      = "${var.database_identifier}-${var.environment}"
  db_subnets         = module.vpc.private_subnets
  db_security_groups = [module.vpc.database_sg]
  unique_string      = local.unique_string
  tags = merge(
    { VPC = module.vpc.vpc_id },
    var.tags,
    local.common_tags,
    { unique_string = local.unique_string }
  )
}

module "dynamo" {
  for_each           = local.dynamodb_metadata
  source             = "../modules/dynamodb"
  table_name         = "${var.environment}-${each.key}"
  environment        = var.environment
  billing_mode       = var.billing_mode
  hash_key           = each.value.hash_key
  hash_key_datatype  = each.value.hash_key_datatype
  range_key_exists   = each.value.range_key_exists
  range_key          = each.value.range_key
  range_key_datatype = each.value.range_key_datatype
  unique_string      = local.unique_string
  tags = merge(
    var.tags,
    local.common_tags,
    { unique_string = local.unique_string }
  )
}

module "sqs" {
  for_each      = toset(["application_alert_queue", "claim_action_event", "customer_auto_credit_review", "customer_reconsilation", "document_management", "erp_file_process", "erp_note_collobration", "event_tracker", "flex_app_pdf_generate_req_queue", "invoice_csv_upload_queue", "invoice_reconsilation", "notification", "notification_email", "notification_task", "portfolio_mapping", "quick_books_data_load_queue", "remote_data_push_queue", "report_generate_queue", "thread_message_event", "tst_inv_queue", "user_activity_event", "user_collection_summary_queue", "zoho_books_data_load_queue", "workflow-runtime-listener-outbound", "workflow_runtime_listener_outbound", "workflow-universal-event"])
  source        = "../modules/sqs"
  queue_name    = each.value == "workflow-universal-event" ? "${var.environment}-${each.value}" : "${var.environment}-${each.value}-${local.unique_string}"
  unique_string = local.unique_string
  environment   = var.environment
  region        = local.aws_region
  account       = local.aws_account
}

# module "ecr" {
#   for_each = local.app_configuration
#   source   = "../modules/ecr"
#   ecr_repo = "${each.key}-${var.environment}"
# }

module "ecs_cluster" {
  source           = "../modules/ecs"
  ecs_cluster_name = "${var.environment}-${var.ecs_cluster_name}"
  unique_string    = local.unique_string
  tags = merge(
    { VPC = module.vpc.vpc_id },
    var.tags,
    local.common_tags,
    { unique_string = local.unique_string }
  )
}

module "external_ecs_service" {
  for_each                 = local.external_app_configuration
  depends_on               = [module.ecs_cluster, module.vpc, module.database]
  source                   = "../modules/ecs_service"
  vpc_id                   = module.vpc.vpc_id
  vpc_name                 = "vpc-${var.vpc_name}-${local.unique_string}"
  app_name                 = each.key
  subnet_ids               = module.vpc.private_subnets
  ecs_cluster_id           = module.ecs_cluster.ecs_cluster_id
  alb_arn                  = module.vpc.external_alb_arn
  fargate_cpu              = each.value.fargate_cpu
  fargate_memory           = each.value.fargate_memory
  containerport            = each.value.containerport
  ecs_endpoint_sg          = module.vpc.ecs_endpoint_sg
  domain_name              = var.domain_name
  aws_account              = local.aws_account
  aws_region               = local.aws_region
  image                    = each.value.image
  alb_sg                   = module.vpc.external_alb_sg
  alb_listener             = module.vpc.external_alb_listener
  path_pattern             = each.value.path_pattern
  priority                 = each.value.priority
  ecr_repo                 = each.value.ecr_repo
  apptype                  = each.value.apptype
  environment              = var.environment
  unique_string            = local.unique_string
  default_tg               = each.value.default_tg
  external_alb_sg          = module.vpc.external_alb_sg
  internal_alb_sg          = module.vpc.internal_alb_sg
  ui_alb_sg                = module.vpc.ui_alb_sg
  source_security_group_id = module.vpc.external_alb_sg
  tags = merge(
    { VPC = module.vpc.vpc_id },
    each.value.tags,
    var.tags,
    local.common_tags,
    { unique_string = local.unique_string }
  )
}

module "internal_ecs_service" {
  for_each                 = local.internal_app_configuration
  depends_on               = [module.ecs_cluster, module.vpc, module.database]
  source                   = "../modules/ecs_service"
  vpc_id                   = module.vpc.vpc_id
  vpc_name                 = "vpc-${var.vpc_name}-${local.unique_string}"
  app_name                 = each.key
  subnet_ids               = module.vpc.private_subnets
  ecs_cluster_id           = module.ecs_cluster.ecs_cluster_id
  alb_arn                  = module.vpc.internal_alb_arn
  fargate_cpu              = each.value.fargate_cpu
  fargate_memory           = each.value.fargate_memory
  containerport            = each.value.containerport
  ecs_endpoint_sg          = module.vpc.ecs_endpoint_sg
  domain_name              = var.domain_name
  aws_account              = local.aws_account
  aws_region               = local.aws_region
  image                    = each.value.image
  alb_sg                   = module.vpc.internal_alb_sg
  alb_listener             = module.vpc.internal_alb_listener
  path_pattern             = each.value.path_pattern
  priority                 = each.value.priority
  default_tg               = each.value.default_tg
  ecr_repo                 = each.value.ecr_repo
  apptype                  = each.value.apptype
  environment              = var.environment
  unique_string            = local.unique_string
  external_alb_sg          = module.vpc.external_alb_sg
  internal_alb_sg          = module.vpc.internal_alb_sg
  ui_alb_sg                = module.vpc.ui_alb_sg
  source_security_group_id = module.vpc.internal_alb_sg
  tags = merge(
    { VPC = module.vpc.vpc_id },
    each.value.tags,
    var.tags,
    local.common_tags,
    { unique_string = local.unique_string }
  )
}

module "ui_ecs_service" {
  for_each                 = local.ui_app_configuration
  depends_on               = [module.ecs_cluster, module.vpc, module.database]
  source                   = "../modules/ecs_service"
  vpc_id                   = module.vpc.vpc_id
  app_name                 = each.key
  subnet_ids               = module.vpc.private_subnets
  ecs_cluster_id           = module.ecs_cluster.ecs_cluster_id
  alb_arn                  = module.vpc.ui_alb_arn
  fargate_cpu              = each.value.fargate_cpu
  fargate_memory           = each.value.fargate_memory
  containerport            = each.value.containerport
  ecs_endpoint_sg          = module.vpc.ecs_endpoint_sg
  domain_name              = var.domain_name
  aws_account              = local.aws_account
  aws_region               = local.aws_region
  image                    = each.value.image
  alb_sg                   = module.vpc.ui_alb_sg
  vpc_name                 = "vpc-${var.vpc_name}-${local.unique_string}"
  alb_listener             = module.vpc.ui_alb_listener
  path_pattern             = each.value.path_pattern
  priority                 = each.value.priority
  default_tg               = each.value.default_tg
  ecr_repo                 = each.value.ecr_repo
  apptype                  = each.value.apptype
  environment              = var.environment
  unique_string            = local.unique_string
  external_alb_sg          = module.vpc.external_alb_sg
  internal_alb_sg          = module.vpc.internal_alb_sg
  ui_alb_sg                = module.vpc.ui_alb_sg
  source_security_group_id = module.vpc.ui_alb_sg
  tags = merge(
    { VPC = module.vpc.vpc_id },
    each.value.tags,
    var.tags,
    local.common_tags,
    { unique_string = local.unique_string }
  )
}

module "lambda_layers" {
  source = "../modules/lambda_layers"
}

module "rule-engine-services" {
  source         = "../modules/lambdas"
  runtime        = "java21"
  lambda_layers  = []
  lambda_handler = "com.svalgo.lambda.RuleCraftBuilderLambdaHandler"
  app_name       = "rule-engine-services"
  filename       = "rule-engine-services"
  code_bucket    = "svalgo-lambda-source-buckets"
  function_name  = "${var.environment}-rule-engine-services-${local.unique_string}"
  unique_string  = local.unique_string
  environment    = var.environment
}

module "sqs-poller-lambda" {
  source         = "../modules/lambdas"
  runtime        = "nodejs18.x"
  lambda_layers  = ["${module.lambda_layers.axios_layer}"]
  lambda_handler = "index.handler"
  app_name       = "sqs-poller-lambda"
  filename       = "sqs-poller-lambda"
  code_bucket    = "svalgo-lambda-source-buckets"
  function_name  = "${var.environment}-sqs-poller-lambda-${local.unique_string}"
  unique_string  = local.unique_string
  environment    = var.environment

}

module "restapi" {
  source                   = "../modules/apigateway"
  app_name                 = "rule-engine"
  api_name                 = "rule-engine"
  aws_account              = local.aws_account
  aws_region               = local.aws_region
  rule_engine_services_arn = module.rule-engine-services.lambda_arn
  environment              = var.environment

}