resource "aws_ec2_transit_gateway_vpc_attachment" "west2_vpc_0ba4df3c22aee26b4" {
  provider = aws.west2

  transit_gateway_id = aws_ec2_transit_gateway.west2.id
  vpc_id             = "vpc-0ba4df3c22aee26b4"

  subnet_ids = [
    "subnet-0ad97ce808b1c5cc3",
    "subnet-0c71c852f3204841b"
  ]

  tags = {
    Name        = "tgw-attach-us-west-2-vpc-0ba4df3c22aee26b4"
    Environment = "prod"
  }
}
