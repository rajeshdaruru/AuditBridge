# PLANTED MISCONFIGURATIONS — see test-infra/README.md

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  # (6) Logging — no aws_flow_log resource attached to this VPC anywhere
  #     in this stack.
}

resource "aws_security_group" "web" {
  name        = "auditbridge-demo-web-sg"
  description = "Demo web tier security group"
  vpc_id      = aws_vpc.main.id

  # (4) Network exposure — SSH open to the world.
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # (5) Network exposure — every port open to the world.
  ingress {
    description = "All ports from anywhere"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
