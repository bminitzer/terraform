resource "aws_route" "app_subnet_0ad97_to_workspaces" {
  provider = aws.west2

  route_table_id         = "rtb-0c172f4a063f73764"
  destination_cidr_block = "172.17.0.0/16"
  transit_gateway_id     = "tgw-0987068a71d03fa7f"
}

resource "aws_route" "app_subnet_0c71_to_workspaces" {
  provider = aws.west2

  route_table_id         = "rtb-0283a18cd4dcbbd40"
  destination_cidr_block = "172.17.0.0/16"
  transit_gateway_id     = "tgw-0987068a71d03fa7f"
}
