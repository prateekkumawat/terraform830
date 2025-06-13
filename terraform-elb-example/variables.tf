variable "orgnization" {}
variable "environment" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {
  type = list 
}
variable "az" {
  type = list
}
variable "aws_ami" {}
variable "aws_instance_type"{}
variable "aws_region" {}
  
