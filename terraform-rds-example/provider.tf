terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
  
   backend s3 {
      bucket = "snooooow"
      key    = "terraform-rds-eample"
      region = "ap-south-1"
    }
   
  cloud { 
    
    organization = "highskyit" 

    workspaces { 
      name = "rds-managmement" 
    } 
  } 

}

provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}