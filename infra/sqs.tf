resource "aws_sqs_queue" "espera_entrega" {
  name             = "espera-entrega"
  delay_seconds    = 0
  max_message_size = 1024
}
