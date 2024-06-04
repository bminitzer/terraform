terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      automation_owner = "DevOps"
      division         = "Technology Infrastructure"
      department       = "DevOps Engineering eXperience"
    }
  }
}

locals {
  tags = {
    Environment = "DEV"
  }
}


# For aws linux 2023
#data "aws_ami" "amzn-linux-2023-ami" {
#  most_recent = true
#  owners      = ["amazon"]

#  filter {
#    name   = "name"
#    values = ["al2023-ami-2023.*-x86_64"]
#  }
#}

# For aws linux 2
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_iam_role" "temp-instance01-ssm-role" {
  name               = "temp-instance01-ssm-role"
  description        = "The role for the SSM Management EC2"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
       "Statement": {
       "Effect": "Allow",
       "Principal": {"Service": "ec2.amazonaws.com"},
       "Action": "sts:AssumeRole"
        }
         }
                        EOF
  tags = {
    stack = "temp-instance01-dev-server"
  }
}

resource "aws_iam_instance_profile" "temp-instance01-iam-profile" {
  name = "temp-instance01_ec2_instance_profile"
  role = aws_iam_role.temp-instance01-ssm-role.name
}

resource "aws_iam_role_policy_attachment" "temp-instance01-ssm-policy" {
  role       = aws_iam_role.temp-instance01-ssm-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy" "ec2-policy" {
  name   = "ec2-policy"
  role   = aws_iam_role.temp-instance01-ssm-role.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ec2terminate",
            "Effect": "Allow",
            "Action": "ec2:TerminateInstances",
            "Resource": "*"
        }
    ]
}
EOF
}

#resource "aws_iam_role_policy" "S3-Policy" {
#  name = "S3-Policy"
#  role = "${aws_iam_role.temp-instance01-iam-role.id}"
#  policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Sid": "VisualEditor0",
#            "Effect": "Allow",
#            "Action": [
#                "s3:ListAccessPointsForObjectLambda",
#                "s3:GetAccessPoint",
#                "s3:PutAccountPublicAccessBlock",
#                "s3:ListAccessPoints",
#                "s3:CreateStorageLensGroup",
#                "s3:ListJobs",
#                "s3:PutStorageLensConfiguration",
#                "s3:ListMultiRegionAccessPoints",
#                "s3:ListStorageLensGroups",
#                "s3:ListStorageLensConfigurations",
#                "s3:GetAccountPublicAccessBlock",
#                "s3:ListAllMyBuckets",
#                "s3:ListAccessGrantsInstances",
#                "s3:PutAccessPointPublicAccessBlock",
#                "s3:CreateJob"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Sid": "VisualEditor1",
#            "Effect": "Allow",
#            "Action": "s3:*",
#            "Resource": [
#                "arn:aws:s3:::r5-nanb-data",
#                "arn:aws:s3:::r5-nanb-data/*"
#            ]
#        }
#    ]
#}
#EOF
#}

resource "aws_instance" "temp-instance01" {
  #  ami                    =  var.ami-id
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t3.small"
  #  instance_type          = "t2.large"
  subnet_id                            = var.subnetid
  vpc_security_group_ids               = [aws_security_group.temp-instance01-SG.id]
  key_name                             = "boaz-test"
  iam_instance_profile                 = aws_iam_instance_profile.temp-instance01-iam-profile.id
  instance_initiated_shutdown_behavior = "terminate"
  user_data                            = <<-EOF
    #!/bin/bash
    sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
    sudo systemctl enable amazon-ssm-agent
    sudo systemctl start amazon-ssm-agent
    sudo useradd -G wheel boaz ; echo Password123!$ | passwd boaz -stdin
    sudo yum update –y
    line="* */1 * * * /bin/shutdown -h now >/dev/null 2>&1"
    (crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
    sudo hostnamectl set-hostname CLOUDEA-10208
                  EOF
  ebs_block_device {
    device_name           = "/dev/xvda"
    delete_on_termination = false
    volume_size           = 30
    volume_type           = "gp3"
    tags = merge(local.tags, {
      Name        = "temp-instance01"
      Description = "Root Device for Instance"
      Environment = "DEV"
      snapshot    = "no"
    })
  }
  tags = merge(local.tags, {
    Name   = "temp-instance01"
    backup = "true"
  })
}


# Create an EIP
#resource "aws_eip" "temp-instance01-eip" {
#  vpc = true
#    tags = {
#      Name = "EIP1"
#      Project = "CLOUD"
#    }
#}

# Associate the EIP with the instance
#resource "aws_eip_association" "temp-instance01-eip" {
#  instance_id   = aws_instance.temp-instance01.id
#  allocation_id = aws_eip.temp-instance01-eip.id
#}


resource "aws_security_group" "temp-instance01-SG" {
  name        = "temp-instance01-dev-sg"
  description = "SG for temp-instance01 Prod Server"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.209.10.0/23"]
    description = "Local CIDR"
  }
  egress {
    from_port   = 0
    to_port     = 0
    description = "Allow traffic outbound"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#resource "aws_route53_record" "route53-record-temp-instance01" {
#  zone_id = var.route53-zone-id
#  name    = "temp-instance01.domain.com"
#  type    = "A"
#  ttl     = 300
#  records = aws_instance.temp-instance01.*.private_ip
#  records = aws_instance.temp-instance01.*.public_ip
#}

