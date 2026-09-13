# Never `terraform apply` this stack — see test-infra/README.md.
# Provider block exists only so `terraform init`/`validate` and Checkov can parse the config.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
