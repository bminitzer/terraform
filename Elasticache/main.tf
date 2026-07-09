provider "aws" {
  region  = "us-east-1"
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_elasticache_subnet_group" "prod_group" {
  name       = "prodsubnetgroup"
  subnet_ids = data.aws_subnets.private.ids
}

resource "aws_security_group" "allow_redis_prod" {
  name        = "allow_redis_prod"
  description = "Allow redis inbound traffic"
  vpc_id      =  var.vpc_id

ingress {
    description      = "Redis from NBCU Networks"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    #tfsec:ignore:aws-vpc-no-public-ingress-sgr
    cidr_blocks      = "${var.nbcu_es_application_ingress}"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_redis_prod"
  }
}

resource "aws_elasticache_replication_group" "redis_cluster_enable" {
  replication_group_id       = "redis-prod-node"
  engine                     = "redis"
  num_node_groups            = 2
  replicas_per_node_group    = 1
  parameter_group_name       = "default.redis7.cluster.on"
  automatic_failover_enabled = true
  engine_version             = "7.0"
  node_type                  = "cache.r6g.large"
  description                = "Prod Cluster"

  subnet_group_name  = aws_elasticache_subnet_group.prod_group.name
  security_group_ids = [aws_security_group.allow_redis_prod.id]
}

