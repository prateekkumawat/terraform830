locals {
  vpc_blocks = {
  for k,v in var.vpc_details : 
  k => {  
    cidr_block             =  v.cidr_block
    Name                   =  v.Name
    instance_tenancy       =  v.instance_tenancy
    enable_dns_hostnames   =  v.enable_dns_hostnames 
    enable_dns_support     =  v.enable_dns_support 
    tags                   =  v.tags
    }
  }
}