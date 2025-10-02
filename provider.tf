provider "aws" {
  region = "sa-east-1"
}

data "aws_region" "current" {}
