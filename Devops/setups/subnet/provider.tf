terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79"
    }
  }
  backend s3 {
    region = "ap-south-1"
  }
}
provider "aws" {
  region = var.aws_region
}