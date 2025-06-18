variable "orgnization" {}
variable "environment" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {
  type = list 
}
variable "az" {
  type = list
}