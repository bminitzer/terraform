########################
# Site-to-Site VPN to us-west-1 TGW
########################

resource "aws_vpn_connection" "west1_active_vpn" {
  provider = aws.west1

  customer_gateway_id = "cgw-02a40a892453e4aee"
  transit_gateway_id  = aws_ec2_transit_gateway.west1.id
  type                = "ipsec.1"

  static_routes_only = true

  tags = {
    Name        = "vpn-us-west-1-active"
    Environment = "prod"
  }
}


resource "aws_ec2_transit_gateway_route" "west1_to_onprem" {
  provider = aws.west1

  destination_cidr_block         = "192.168.90.0/24"
  transit_gateway_route_table_id = aws_ec2_transit_gateway.west1.association_default_route_table_id
  transit_gateway_attachment_id  = aws_vpn_connection.west1_active_vpn.transit_gateway_attachment_id
}
