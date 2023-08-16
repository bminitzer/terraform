resource "aws_security_group" "nsg_lb" {
  name        = "${var.app}-${var.environment}-lb"
  description = "Allow connections from external resources while limiting connections from ${var.app}-${var.environment}-lb to internal resources"
  vpc_id      = var.vpc_id

  tags = var.tags
}

resource "aws_security_group" "nsg_task" {
  name        = "${var.app}-${var.environment}-task"
  description = "Limit connections from internal resources while allowing ${var.app}-${var.environment}-task to connect to all external resources"
  vpc_id      = var.vpc_id

  tags = var.tags
}

# Rules for the LB (Targets the task SG)

resource "aws_security_group_rule" "nsg_lb_egress_rule" {
  description              = "Only allow SG ${var.app}-${var.environment}-lb to connect to ${var.app}-${var.environment}-task on port ${var.container_port}"
  type                     = "egress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nsg_task.id
  security_group_id        = aws_security_group.nsg_lb.id
}

# Rules for the TASK (Targets the LB SG)
resource "aws_security_group_rule" "nsg_task_ingress_rule" {
  description              = "Only allow connections from SG ${var.app}-${var.environment}-lb on port ${var.container_port}"
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nsg_lb.id
  security_group_id        = aws_security_group.nsg_task.id
}

resource "aws_security_group_rule" "nsg_task_ingress_rule2" {
  description       = "Only allow connections from SG ${var.app}-${var.environment}-lb on port ${var.container_port}"
  type              = "ingress"
  from_port         = var.lb_port
  to_port           = var.lb_port
  protocol          = "tcp"
  cidr_blocks       = ["172.17.0.0/16"]
  security_group_id = aws_security_group.nsg_task.id
}

resource "aws_security_group_rule" "nsg_task_ingress_rule3" {
  description       = "Only allow connections from SG ${var.app}-${var.environment}-lb on port ${var.container_port}"
  type              = "ingress"
  from_port         = var.healthcheck_port
  to_port           = var.healthcheck_port
  protocol          = "tcp"
  cidr_blocks       = ["172.17.0.0/16"]
  security_group_id = aws_security_group.nsg_task.id
}

#Removed for PROD
#resource "aws_security_group_rule" "nsg_task_ingress_rule2" {
#  type              = "ingress"
#  from_port         = var.healthcheck_port
#  to_port           = var.healthcheck_port
#  protocol          = "tcp"
#  cidr_blocks       = ["0.0.0.0/0"]
#  security_group_id = aws_security_group.nsg_task.id
#}

resource "aws_security_group_rule" "nsg_task_egress_rule" {
  description = "Allows task to establish connections to all resources"
  type        = "egress"
  from_port   = "0"
  to_port     = "0"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.nsg_task.id
}
