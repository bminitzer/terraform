variable "lambda_function_name" {
  default = "check_acm_ssl_expiration"
}

variable "region" {
  default = "us-east-1"
}

variable "slack_webhook_url" {
  description = "The Slack webhook URL to send notifications"
  default     = "https://hooks.slack.com/services/"
}

variable "slack_channel" {
  default = "#cloudops-team-notifications"
}
