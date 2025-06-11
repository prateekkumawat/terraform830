# HCL ----> hashicorp Configuration Language
yaml and json are also supported pyhon go
# how to use for_each with a loop in Terraform
variable "names" {
  type    = list(string)
  default = ["Alice", "Bob", "Charlie"]
}

variable "mixvars" {
  type    = list
  default = [ "prateek", 30 , 20 , "anjani"]
}

resource "null" "name" {
  for_each = var.names
    key1 = each.value

}

######

variable "names2" {
  type = map(object({
    name = string
    age  = number
    job  = list(string) 
  }))
}

resource "null_resource" "name" {
  for_each = var.names2
    key1     = each.value.name
    key2     = each.value.age
    key3     = each.value.job
}

output "names" {
  value = [for key, value in null_resource.name : key => }

        key1   = value.key1
        key2   = value.key2
        key3   = value.key3 
       
}

for_each  is meta-argument that can be used with resources, modules, and data sources.
 It allows you to create multiple instances of a resource or module based on the items in a collection (like a list or map).

 for loop is a programming construct that allows you to iterate over a collection of items, executing a block of code for each item in the collection. In Terraform, you can use for loops within expressions to transform collections or generate new collections.