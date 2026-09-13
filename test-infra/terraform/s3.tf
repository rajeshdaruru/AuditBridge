# PLANTED MISCONFIGURATIONS — see test-infra/README.md

resource "aws_s3_bucket" "data" {
  bucket = "auditbridge-demo-data-bucket"

  # (1) Encryption — no aws_s3_bucket_server_side_encryption_configuration
  #     for this bucket anywhere in this stack.

  # (3) Logging — no `logging` block / aws_s3_bucket_logging resource.
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = aws_s3_bucket.data.id

  # (2) Network exposure — all four should be true; left false so the
  #     bucket can still be made public.
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
