# PLANTED MISCONFIGURATIONS — see test-infra/README.md

resource "aws_ebs_volume" "data" {
  availability_zone = "us-east-1a"
  size              = 10

  # (11) Encryption — volume is not encrypted at rest.
  encrypted = false
}
