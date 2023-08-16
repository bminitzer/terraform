# Add Security so passwords are not in TF Files.

#variable "secret_name" {
#  default = "/d/prod/dev-db"
#}
#data "aws_secretsmanager_secret" "ecs" {
#  name = var.secret_name
#}
#data "aws_secretsmanager_secret_version" "ecs_secret" {
#  secret_id = data.aws_secretsmanager_secret.ecs.id
#}
#locals {
#  GATEWAY_DB_USER           = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.ecs_secret.secret_string))[join("", [var.environment, "DatabaseUserName"])]
#  GATEWAY_DB_PASS           = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.ecs_secret.secret_string))[join("", [var.environment, "DatabasePassword"])]
#  GATEWAY_KEYSTORE_PASSWORD = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.ecs_secret.secret_string))[join("", [var.environment, "GateWayKeyStorePassword"])]
#}
