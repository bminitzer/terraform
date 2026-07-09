resource "aws_ec2_transit_gateway_route" "west1_to_west2_vpc_172_17" {
  provider = aws.west1

  destination_cidr_block         = "172.17.0.0/16"
  transit_gateway_route_table_id = "tgw-rtb-00538883cba480478"
  transit_gateway_attachment_id  = "tgw-attach-0c7ecc882da2c7801"
}
