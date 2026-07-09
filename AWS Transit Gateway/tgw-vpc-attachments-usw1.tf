resource "aws_ec2_transit_gateway_vpc_attachment" "west1_vpc_2170b644" {
  provider = aws.west1

  transit_gateway_id = aws_ec2_transit_gateway.west1.id
  vpc_id             = "vpc-2170b644"

  subnet_ids = [
    "subnet-6377a906",
    "subnet-e8cdd3ae"

  ]

  tags = {
    Name        = "tgw-attach-us-west-1-vpc-2170b644"
    Environment = "prod"
  }
}
