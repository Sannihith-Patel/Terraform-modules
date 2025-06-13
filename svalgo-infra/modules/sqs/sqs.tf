resource "aws_sqs_queue" "sqs-queue" {
  name                      = var.queue_name
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  tags = {
    Environment = "production"
  }
}


resource "aws_sqs_queue_policy" "sqs-queue-policy" {
  queue_url = aws_sqs_queue.sqs-queue.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "__owner_statement"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${var.account}:root"
      }
      Action : "SQS:*"
      Resource = aws_sqs_queue.sqs-queue.arn
    }]
  })

}
