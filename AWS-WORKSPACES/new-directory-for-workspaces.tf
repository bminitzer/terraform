provider "aws" {
  alias  = "west2"
  region = "us-west-2"
}

resource "aws_directory_service_directory" "workspaces_ad_connector_west2_new_vpc" {
  provider = aws.west2

  name        = "forwardline.local"
  short_name  = "FORWARDLINE"
  password    = var.ad_connector_password
  size        = "Small"
  type        = "ADConnector"
  description = "AD Connector for WorkSpaces in vpc-00a6f7c647d696d96"

  connect_settings {
    vpc_id = "vpc-00a6f7c647d696d96"

    subnet_ids = [
      "subnet-06faab87e59f5243a",
      "subnet-0d05bfa968d4ee0df"
    ]

    customer_dns_ips = [
      "10.0.2.10",
      "10.0.3.10"
    ]

    customer_username = "adconnector"
  }

  tags = {
    Name        = "workspaces-ad-connector-forwardline-local"
    Environment = "prod"
  }
}
