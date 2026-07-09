terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "west2"
  region = "us-west-2"
}

provider "aws" {
  alias  = "west1"
  region = "us-west-1"
}

resource "aws_ec2_transit_gateway" "west2" {
  provider = aws.west2

  description                     = "Transit Gateway us-west-2"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name        = "tgw-us-west-2"
    Environment = "prod"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ec2_transit_gateway" "west1" {
  provider = aws.west1

  description                     = "Transit Gateway us-west-1"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name        = "tgw-us-west-1"
    Environment = "prod"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Name default TGW route table - us-west-2
resource "aws_ec2_tag" "west2_default_tgw_route_table_name" {
  provider    = aws.west2
  resource_id = aws_ec2_transit_gateway.west2.association_default_route_table_id
  key         = "Name"
  value       = "tgw-rtb-us-west-2-default"
}

# Name default TGW route table - us-west-1
resource "aws_ec2_tag" "west1_default_tgw_route_table_name" {
  provider    = aws.west1
  resource_id = aws_ec2_transit_gateway.west1.association_default_route_table_id
  key         = "Name"
  value       = "tgw-rtb-us-west-1-default"
}

resource "aws_ec2_transit_gateway_peering_attachment" "west1_to_west2" {
  provider = aws.west1

  transit_gateway_id      = aws_ec2_transit_gateway.west1.id
  peer_transit_gateway_id = aws_ec2_transit_gateway.west2.id
  peer_region             = "us-west-2"

  tags = {
    Name        = "tgw-peer-us-west-1-to-us-west-2"
    Environment = "prod"
  }
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "west2_accept" {
  provider = aws.west2

  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.west1_to_west2.id

  tags = {
    Name        = "tgw-peer-us-west-2-accept"
    Environment = "prod"
  }
}

output "west2_tgw_id" {
  description = "Transit Gateway ID in us-west-2"
  value       = aws_ec2_transit_gateway.west2.id
}

output "west1_tgw_id" {
  description = "Transit Gateway ID in us-west-1"
  value       = aws_ec2_transit_gateway.west1.id
}

output "tgw_peering_attachment_id" {
  description = "Transit Gateway peering attachment ID"
  value       = aws_ec2_transit_gateway_peering_attachment.west1_to_west2.id
}

output "west2_tgw_route_table_id" {
  description = "Default TGW route table ID in us-west-2"
  value       = aws_ec2_transit_gateway.west2.association_default_route_table_id
}

output "west1_tgw_route_table_id" {
  description = "Default TGW route table ID in us-west-1"
  value       = aws_ec2_transit_gateway.west1.association_default_route_table_id
}
