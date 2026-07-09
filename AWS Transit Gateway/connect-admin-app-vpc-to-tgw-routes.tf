resource "aws_route" "workspaces_az2_to_1032" {
  provider = aws.west2

  route_table_id         = "rtb-0c92ee8af1a92d6d8"
  destination_cidr_block = "10.32.12.0/23"
  transit_gateway_id     = "tgw-0987068a71d03fa7f"
}

resource "aws_route" "workspaces_az1_to_1032" {
  provider = aws.west2

  route_table_id         = "rtb-03ee3a00c15645211"
  destination_cidr_block = "10.32.12.0/23"
  transit_gateway_id     = "tgw-0987068a71d03fa7f"
}
