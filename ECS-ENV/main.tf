terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      automation_owner  = "Boaz"
      automation_region = "us-west-2"
      JIRA_TICKET       = "TICKET1"
    }
  }
}


data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Tier = "Private"
  }

}
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Tier = "Public"
  }

}
