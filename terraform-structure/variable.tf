variable "orgnization_name" {}
variable "environment_name" {}
variable "region" {}
variable "vpc_details" {
  type = map(object({
    cidr_block = string
    enable_dns_hostnames = optional(bool, true)
    enable_dns_support = optional(bool, true)
    prefix = optional(string)   
  }))
  
}