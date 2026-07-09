########################
# Variables
########################

variable "west1_vpc_cidr" {
  description = "CIDR block of the us-west-1 VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "west2_vpc_cidr" {
  description = "CIDR block of the us-west-2 VPC"
  type        = string
  default     = "10.32.12.0/23"
}

########################
# TGW Routes
########################

# Route from us-west-1 TGW to us-west-2 VPC over TGW peering
resource "aws_ec2_transit_gateway_route" "west1_to_west2_vpc" {
  provider = aws.west1

  destination_cidr_block         = var.west2_vpc_cidr
  transit_gateway_route_table_id = aws_ec2_transit_gateway.west1.association_default_route_table_id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.west1_to_west2.id
}

# Route from us-west-2 TGW to us-west-1 VPC over TGW peering
resource "aws_ec2_transit_gateway_route" "west2_to_west1_vpc" {
  provider = aws.west2

  destination_cidr_block         = var.west1_vpc_cidr
  transit_gateway_route_table_id = aws_ec2_transit_gateway.west2.association_default_route_table_id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.west2_accept.id
}
