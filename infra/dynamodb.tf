resource "aws_dynamodb_table" "eventos_pizzaria" {
  name         = "eventos-pizzaria"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pedido"
  range_key    = "status"

  attribute {
    name = "pedido"
    type = "S"
  }

  attribute {
    name = "status"
    type = "S"
  }
}
