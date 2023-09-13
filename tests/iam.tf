#-------------------------------------------------------
# IAM Role Resource and Data Source
#-------------------------------------------------------

locals {
  role_name = lower("${var.service_name}-${var.environment}-${var.region}-glue-role")
}

// Data Source to fetch IAM Role ARN if provided
data "aws_iam_role" "glue_role" {
  count = var.iam_role_name != "" ? 1 : 0
  name  = var.iam_role_name
}

// Data Source to fetch IAM Managed Policy ARN
data "aws_iam_policy" "glue-policy" {
  count = var.iam_role_name != "" ? 0 : 1
  name  = "AWSGlueServiceRole"
}

data "aws_iam_policy" "s3-policy" {
  count = var.iam_role_name != "" ? 0 : 1
  name  = "AmazonS3FullAccess"
}

data "aws_iam_policy" "cloudwatch-policy" {
  count = var.iam_role_name != "" ? 0 : 1
  name  = "CloudWatchLogsFullAccess"
}

// Create IAM Role
resource "aws_iam_role" "glue_role" {
  count = var.iam_role_name == "" ? 1 : 0
  name  = local.role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "glue.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = merge(local.common_tags, { Name = local.role_name })
}

// Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "glue_role_policy_attachment" {
  count = var.iam_role_name != "" ? 0 : 1

  policy_arn = data.aws_iam_policy.glue-policy[0].arn
  role       = aws_iam_role.glue_role[0].name
}

resource "aws_iam_role_policy_attachment" "cloudwatch_role_policy_attachment" {
  count = var.iam_role_name != "" ? 0 : 1

  policy_arn = data.aws_iam_policy.cloudwatch-policy[0].arn
  role       = aws_iam_role.glue_role[0].name
}

resource "aws_iam_role_policy_attachment" "s3_role_policy_attachment" {
  count = var.iam_role_name != "" ? 0 : 1

  policy_arn = data.aws_iam_policy.s3-policy[0].arn
  role       = aws_iam_role.glue_role[0].name
}
