# PLANTED MISCONFIGURATIONS — see test-infra/README.md

resource "aws_iam_role" "app" {
  name = "auditbridge-demo-app-role"

  # (8) IAM — trust policy allows any principal to assume this role.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { AWS = "*" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "admin" {
  name = "auditbridge-demo-admin-policy"

  # (7) IAM — wildcard action against a wildcard resource.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_admin" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.admin.arn
}
