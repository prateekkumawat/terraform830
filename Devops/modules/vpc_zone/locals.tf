locals {
  vpc_blocks = {
  for k,v in var.vpc_details : 
  k => {  
    cidr_block             =  v.cidr_block
    Name                   =  v.Name
    instance_tenancy       =  v.instance_tenancy
    enable_dns_hostnames   =  v.enable_dns_hostnames 
    enable_dns_support     =  v.enable_dns_support 
    tags                   =  merge(v.tags , v.prefix == null ? tomap({ Name: "${v.Name}"}): tomap({ Name: "${v.prefix}-${v.Name}"}))
    }
  }
}