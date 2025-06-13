resource "aws_api_gateway_rest_api" "rule-engine" {
  body = templatefile("${path.module}/template/${var.app_name}.json", {
    aws_account              = var.aws_account
    aws_region               = var.aws_region
    rule-engine-services-arn = var.rule_engine_services_arn
    environment              = var.environment
  })

  name = var.api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "rule-engine" {
  rest_api_id = aws_api_gateway_rest_api.rule-engine.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.rule-engine.body))
  }

  #   lifecycle {
  #     create_before_destroy = true
  #   }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.rule-engine.id
  rest_api_id   = aws_api_gateway_rest_api.rule-engine.id
  stage_name    = var.environment
}