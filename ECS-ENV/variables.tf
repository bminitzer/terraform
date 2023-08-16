# The AWS region to use for the dev environment's infrastructure
variable "region" {
  default = "us-west-2"
}
variable "accountId" {
  default = "000312342342150"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Development"
    JIRA_TICKET = "XXXX"
  }
}

# The application's name
variable "app" {
  default = "api"
}

# The environment that is being built
variable "environment" {
  default = "Development"
}
variable "environmentshort" {
  default = "dev"
}
# The port the container will listen on, used for load balancer health check
# Best practice is that this value is higher than 1024 so the container processes
# isn't running at root.
variable "container_port" {
  default = "80"
}

# The port the load balancer will listen on, then direct traffic to the applicable target group/s
variable "lb_port" {
  default = "443"
}

# The load balancer protocol
variable "lb_protocol" {
  default = "HTTPS"
}
variable "healthcheck_port" {
  default = "80"
}

# Network configuration

# DEV VPC
variable "vpc_id" {
  default = "vpc-03d12523525520"
}

variable "aws_s3_bucket_name" {
  description = "The name of the bucket that will receive the log objects"
  default     = "api-dev-us-west-2"
}

variable "route53-zone-id" {
  default     = "ZRDWDGJO8TRP47Q"
  description = "Zone id for domain"
}
