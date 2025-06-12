resource "aws_vpc" "use1" {
  for_each = local.vpc_blocks
  cidr_block = each.value.cidr_block
  instance_tenancy = each.value.instance_tenancy
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support = each.value.enable_dns_support
  tags = each.value.tags
}