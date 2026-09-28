terraform {
  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# Generated during the run, never saved anywhere by Terraform
ephemeral "random_password" "db" {
  length  = 20
  special = true
}

resource "aws_ssm_parameter" "db_password" {
  name             = "/tf-secrets-demo/db-password"
  type             = "SecureString"
  value_wo         = ephemeral.random_password.db.result
  value_wo_version = 1
}
