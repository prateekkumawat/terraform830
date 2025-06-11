variable "aws_region" {}
variable "orgnization_name" {}
variable "environment_name" {}
variable "vpc_cidr_block" {}    
variable "azs"{
    type = list
}
variable "subnet_cidr_blocks" {
    type = list
}
