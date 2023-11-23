resource "aws_iam_role" "vpc_flow_log_role" {
  name = "${var.vpc_name}-flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "vpc_flow_log_policy" {
  name = "${var.vpc_name}-flow-log-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Effect = "Allow",
        Resource = var.enable_vpc_flow_logs ? [
          "${aws_cloudwatch_log_group.vpc_flow_log[0].arn}:*"
        ] : []
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "vpc_flow_log_policy_attachment" {
  # checkov:skip=CKV_AWS_158: Checkov check ignored based on project requirements.
  role       = aws_iam_role.vpc_flow_log_role.name
  policy_arn = aws_iam_policy.vpc_flow_log_policy.arn
}


resource "aws_cloudwatch_log_group" "vpc_flow_log" {
  # checkov:skip=CKV_AWS_158: Encryption not required
  count             = var.enable_vpc_flow_logs ? 1 : 0
  name              = "${var.vpc_name}-flow-log-group"
  retention_in_days = 365
}

resource "aws_flow_log" "vpc_flow_log" {
  count           = var.enable_vpc_flow_logs ? 1 : 0
  log_destination = aws_cloudwatch_log_group.vpc_flow_log[count.index].arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id
  iam_role_arn    = aws_iam_role.vpc_flow_log_role.arn
}
