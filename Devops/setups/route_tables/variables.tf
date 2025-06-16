variable "routetable_details"{
    type = map(object({
        vpc_id    = string 
        tags      = map(string)
    }))
}
variable "aws_region" {}
