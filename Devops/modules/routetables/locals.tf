locals {
  routetable_blocks = { 
    for  k, v in var.var.routetable_details : 
      k => { 
         vpc_id  = v.vpc_id
         tags    = v.tags
      }
  }
}