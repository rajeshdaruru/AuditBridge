# test-infra/terraform

A throwaway Terraform stack used only as a target for local scanning and the PR-automation demo. **Never `terraform apply` this** — it exists to be deliberately non-compliant so Checkov, the RAG grounding, and the agent's remediation loop have real findings to work against.

## Planted misconfigurations (10)

| # | File | Resource | Category | Issue |
|---|------|----------|----------|-------|
| 1 | `s3.tf` | `aws_s3_bucket.data` | Encryption | No server-side encryption configuration |
| 2 | `s3.tf` | `aws_s3_bucket_public_access_block.data` | Network exposure | Public access block disabled |
| 3 | `s3.tf` | `aws_s3_bucket.data` | Logging | No access logging configured |
| 4 | `network.tf` | `aws_security_group.web` | Network exposure | SSH (22) open to `0.0.0.0/0` |
| 5 | `network.tf` | `aws_security_group.web` | Network exposure | All ports open to `0.0.0.0/0` |
| 6 | `network.tf` | `aws_vpc.main` | Logging | No VPC flow logs |
| 7 | `iam.tf` | `aws_iam_policy.admin` | IAM | Wildcard action + resource (`"*"`/`"*"`) |
| 8 | `iam.tf` | `aws_iam_role.app` | IAM | Assume-role policy trusts any principal (`"*"`) |
| 9 | `rds.tf` | `aws_db_instance.primary` | Encryption | `storage_encrypted = false` |
| 10 | `rds.tf` | `aws_db_instance.primary` | Network exposure | `publicly_accessible = true` |
| 11 | `compute.tf` | `aws_ebs_volume.data` | Encryption | `encrypted = false` |

(11 planted, slightly over the 8–10 target, for margin if Checkov doesn't flag one as expected.)
