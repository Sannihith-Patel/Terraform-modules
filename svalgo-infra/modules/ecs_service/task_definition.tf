data "aws_iam_policy_document" "ecs_tasks_execution_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_tasks_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_tasks_execution_role" {
  name               = "${var.app_name}-ecs-task-execution-role-${var.unique_string}"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_execution_role.json
  tags = merge(
    { Name = "${var.app_name}-ecs-task-execution-role" },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "ecs_tasks_execution_role" {
  role       = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_logs_access" {
  role       = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.app_name}-ecs-task-role-${var.unique_string}"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role.json
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_s3_policy" {
  count      = !contains(["authorizenetapi"], "${var.app_name}") ? 1 : 0
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_rds_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
}
resource "aws_iam_role_policy_attachment" "ecsTaskRole_sqs_policy" {
  count      = !contains(["algo-dms", "authorizenetapi"], "${var.app_name}") ? 1 : 0
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_cognito_policy" {
  count      = "${var.app_name}" == "onboarding" ? 1 : 0
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_dynamo_policy" {
  count      = "${var.app_name}" == "message-services" ? 1 : 0
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_cloudwatch_log_group" "ecs_loggroup" {
  name = "/ecs/${var.unique_string}/${var.app_name}"

  tags = merge(
    { Name = "${var.app_name}-${var.unique_string}-loggroup" },
    var.tags
  )
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  depends_on               = [aws_cloudwatch_log_group.ecs_loggroup]
  family                   = "${var.app_name}-${var.environment}-${var.unique_string}"
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = templatefile("${path.module}/template/${var.app_name}.json", {
    aws_account = var.aws_account
    aws_region  = var.aws_region
    ecr_repo    = var.ecr_repo
    image_tag   = var.image
    environment = var.environment
    loggroup    = "/ecs/${var.app_name}"
  })
}
