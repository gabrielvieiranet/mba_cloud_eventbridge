resource "aws_lambda_function" "event_lambda" {
  count            = length(local.lambdas)
  function_name    = local.lambdas[count.index]
  handler          = "handler.lambda_handler"
  runtime          = "python3.9"
  filename         = data.archive_file.lambda_zip[count.index].output_path
  source_code_hash = data.archive_file.lambda_zip[count.index].output_base64sha256
  role             = aws_iam_role.lambda_exec.arn
}

resource "aws_lambda_event_source_mapping" "sqs_event_source" {
  event_source_arn = aws_sqs_queue.espera_entrega.arn
  function_name    = aws_lambda_function.event_lambda[2].function_name
  batch_size       = 5
}
