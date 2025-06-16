terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
  
   backend s3 {
      bucket = "snoooooow"
      key    = "terraform-module-used"
      region = "ap-south-1"
    }
}  

provider "aws" {
  region = "ap-south-1"
}