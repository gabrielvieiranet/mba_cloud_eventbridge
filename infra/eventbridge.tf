resource "aws_cloudwatch_event_bus" "pizzaria_event_bus" {
  name = "pizzaria"
}

# ENVIA PARA LAMBDA DE PERSISTENCIA NO DYNAMO #################################
resource "aws_cloudwatch_event_rule" "pizza_status_change" {
  name           = "PizzaStatusChange"
  description    = "Capture changes in pizza status"
  event_bus_name = aws_cloudwatch_event_bus.pizzaria_event_bus.name

  event_pattern = jsonencode({
    "source" : ["com.pizza.status"],
    "detail-type" : ["Alteracao Pizza"]
  })
}

resource "aws_cloudwatch_event_target" "send_to_lambda_persist" {
  rule           = aws_cloudwatch_event_rule.pizza_status_change.name
  event_bus_name = aws_cloudwatch_event_bus.pizzaria_event_bus.name
  target_id      = "SendToLambdaPersist"
  arn            = aws_lambda_function.event_lambda[0].arn
}

resource "aws_lambda_permission" "allow_eventbridge_persist" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.event_lambda[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.pizza_status_change.arn
}

# ENVIA PARA LAMBDA PRODUCER DE SQS ##########################################
resource "aws_cloudwatch_event_rule" "pizza_ready_change" {
  name           = "PizzaReadyChange"
  description    = "Capture pizzas that are ready"
  event_bus_name = aws_cloudwatch_event_bus.pizzaria_event_bus.name

  event_pattern = jsonencode({
    "source" : ["com.pizza.status"],
    "detail-type" : ["Alteracao Pizza"],
    "detail" : {
      "status" : ["pronto"]
    }
  })
}

resource "aws_cloudwatch_event_target" "send_to_lambda_producer" {
  rule           = aws_cloudwatch_event_rule.pizza_ready_change.name
  event_bus_name = aws_cloudwatch_event_bus.pizzaria_event_bus.name
  target_id      = "SendToLambdaProducer"
  arn            = aws_lambda_function.event_lambda[1].arn
}

resource "aws_lambda_permission" "allow_eventbridge_producer" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.event_lambda[1].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.pizza_ready_change.arn
}
