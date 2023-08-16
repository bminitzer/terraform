# creates an application role that the container/task runs as
resource "aws_iam_role" "app_role" {
  name               = "${var.app}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.app_role_assume_role_policy.json
}

# assigns the app policy
resource "aws_iam_role_policy" "app_policy" {
  name   = "${var.app}-${var.environment}"
  role   = aws_iam_role.app_role.id
  policy = data.aws_iam_policy_document.app_policy.json
}

data "aws_iam_policy_document" "app_policy" {
  statement {
    actions = [
      "ecs:DescribeClusters",
    ]

    resources = [
      aws_ecs_cluster.app.arn,
    ]
  }
}

resource "aws_iam_role_policy_attachment" "ecs-ssm-role-policy-attachment-task" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_role_policy_attachment" "ecs-ssm-role-policy-attach-app" {
  role       = aws_iam_role.app_role.id
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

data "aws_iam_policy_document" "app_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${var.accountId}:role/ecsServiceRole-${var.environmentshort}",
      ]
    }
  }
}
