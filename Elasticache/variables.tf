variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-0a6cc523b73ff5b07"
}

variable "nbcu_es_application_ingress" {
  description = "The networks that are allowed to reach the application"
  type        = list(string)
  default     = ["10.0.0.0/8","22.0.0.0/8","100.96.0.0/11"] 
}
