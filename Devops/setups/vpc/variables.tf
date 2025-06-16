variable aws_region {}
variable "vpc_details" {
  type = map(object({
    cidr_block       = string
    Name             = string
    instance_tenancy = optional(string)
    tags             = map(string)
    prefix           = string
  }))
}