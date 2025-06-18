terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../module/vpc/"
 
  orgnization = "highsky-devops"
  environment = "pp"
  vpc_cidr = "10.10.0.0/16"
  subnet_cidr = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.4.0/24"]
  az = ["ap-south-1a", "ap-south-1b"]
}

module "aws_security_group" {
  source = "../module/security_group"

  orgnization = "highsky-devops"
  environment = "pp"
  aws_vpc_id = module.vpc.vpc_id
}

module "key_name" {
    source = "../module/keys"
    #key_name = "use1-pp"
    key_name = var.key_name
}

module "ec2" {
  source = "../module/ec2"

  orgnization = "highsky-devops"
  environment = "pp"
  aws_ami = "ami-0b09627181c8d5778"
  aws_instance_type = "t2.micro"
  instance_subnet_id = module.vpc.subnet3_id
  aws_instance_keypair = module.key_name.use1inskeypair
  aws_securitygroup_id = module.aws_security_group.security_group_use1_id
}