############################
# Existing IDs
############################

locals {
  west1_tgw_id = "tgw-01da63d8f944737e8"
  west2_tgw_id = "tgw-0987068a71d03fa7f"

  west1_vpc_cidr = "10.0.0.0/16"
}

############################
# ONLY create west2 attachment
############################

resource "aws_ec2_transit_gateway_vpc_attachment" "west2_vpc" {
  provider = aws.west2

  transit_gateway_id = local.west2_tgw_id
  vpc_id             = "vpc-00a6f7c647d696d96"

  subnet_ids = [
    "subnet-06faab87e59f5243a",
    "subnet-0d05bfa968d4ee0df",
    "subnet-065c695469223299e"
  ]

  tags = {
    Name = "tgw-attach-us-west-2-vpc-00a6f7c647d696d96"
  }
}

############################
# VPC ROUTES (us-west-2 → west1)
############################

resource "aws_route" "west2_rtb_0c92_to_west1" {
  provider = aws.west2

  route_table_id         = "rtb-0c92ee8af1a92d6d8"
  destination_cidr_block = local.west1_vpc_cidr
  transit_gateway_id     = local.west2_tgw_id
}

resource "aws_route" "west2_rtb_03ee_to_west1" {
  provider = aws.west2

  route_table_id         = "rtb-03ee3a00c15645211"
  destination_cidr_block = local.west1_vpc_cidr
  transit_gateway_id     = local.west2_tgw_id
}

resource "aws_route" "west2_rtb_07c7_to_west1" {
  provider = aws.west2

  route_table_id         = "rtb-07c7a1ae940725a2d"
  destination_cidr_block = local.west1_vpc_cidr
  transit_gateway_id     = local.west2_tgw_id
}


## Add Routes to vpc-2170b644 | FLDataCenterVPC to the TGW that will route to the TGW in us-west-1


resource "aws_route" "west1_rtb_1701_to_west2" {
  provider = aws.west1

  route_table_id         = "rtb-1701cc72"
  destination_cidr_block = "172.17.0.0/16"
  transit_gateway_id     = "tgw-01da63d8f944737e8"
}

resource "aws_route" "west1_rtb_1601_to_west2" {
  provider = aws.west1

  route_table_id         = "rtb-1601cc73"
  destination_cidr_block = "172.17.0.0/16"
  transit_gateway_id     = "tgw-01da63d8f944737e8"
}
